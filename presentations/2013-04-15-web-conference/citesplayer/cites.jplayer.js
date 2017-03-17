// Function citesplayer() constructs a class that instantiates a jplayer instance which includes a caption overlay. Video size
// is hardcoded to 360x640. This setting is found near the end of this file.
//
// Note: This script requires jQuery 1.5+.
//
// @param(id string) id is the html id of the container object for the video player markup - usually a <div>.
// @param(options object) options contains the attribute definitions for the player instance.
//
// Currently accepted options are:
//    mp4:  url of the mp4 formatted video file
//    ogv: url of the ogg formatted video file
//    webm: url of the webm formatted video file
//    poster: url of the image to use as the poster
//    captions: url of the captions file. Must be formatted in ensemble xml.
//
// @return N/A
//
var g_swfPath = "http://itaccessibility.illinois.edu/citesplayer"; // this must point to the correct directory for the server

function citesplayer (id, options) {
   this.id = id;
   this.playerid = 'player-' + id;
   this.$container = jQuery('#' + id);
   this.mp4 = options.mp4;
   this.ogv = options.ogv;
   this.webm = options.webm;
   this.poster = options.poster;
   this.suppliedVideo = "";
   this.objEvents = [];
   this.bCaptionsLoaded = false;
   this.ndx = 0;

   //----------------- Store all the variables ----------------------
 
   // Create the supplied video string
   if (this.mp4) {
      this.suppliedVideo += "m4v";
   }

   if (this.ogv) {
      if (this.suppliedVideo.length > 0) {
         this.suppliedVideo += ", ogv";
      }
      else {
         this.suppliedVideo += "ogv";
      }
   }

   if (this.webm) {
      if (this.suppliedVideo.length > 0) {
         this.suppliedVideo += ", webm";
      }
      else {
         this.suppliedVideo += "webm";
      }
   }


	// if the user supplied height and width info
	if (options.width) {
    this.width = options.width;
	}
  else {
    this.width = '640px';
	}

	if (options.height) {
	  this.height = options.height;
  }
  else {
    this.height = '360px';
	}

  if (options.title) {
     this.title = options.title;
  }


   // Add player markup
   this.addMarkup();

   // Create handles to markup containers
   this.$caption = this.$container.find('div.caption');
   this.$captionControls = this.$container.find('button.jp-captions, button.jp-captions-off');
   this.$time = this.$container.find('div.jp-current-time');

   // If the user specified captions, make an ajax request for the file.
   if (options.captions) {
      this.requestCaptions(options.captions); // prepend the php path
   }
   else {
      // We do not have captions, remove the caption controls
      this.$captionControls.parent().remove();
   }

   // Create an instance of the player
   this.createInstance();

} // End citesplayer() constructor.

// Function addMarkup() creates the markup necessary for the player
//
// @params N/A
//
// @return N/A
//
citesplayer.prototype.addMarkup = function() {

   var markup = '<div class="jp-type-single">'
            + '<div id="' + this.playerid + '" class="jp-jplayer"></div>'
            + '<div class="jp-gui">'
            + '<div class="jp-video-play">'
            + '<a href="javascript:;" class="jp-video-play-icon">play</a>'
            + '</div>'
            + '<div class="jp-interface">'
            + '<div class="caption"></div>'
            + '<div class="jp-progress">'
            + '<div class="jp-seek-bar">'
            + '<div class="jp-play-bar"></div>'
            + '</div>'
            + '</div>'
            + '<div class="jp-current-time"></div>'
            + '<div class="jp-duration"></div>'
            + '<div class="jp-controls-holder">'
            + '<ul class="jp-controls">'
            + '<li><button class="jp-play">play</button></li>'
            + '<li><button class="jp-pause">pause</button></li>'
            + '<li><button class="jp-stop">stop</button></li>'
            + '<li><button class="jp-mute" title="mute">mute</button></li>'
            + '<li><button class="jp-unmute" title="unmute">unmute</button></li>'
            + '<li><button class="jp-volume-max" title="max volume">max volume</button></li>'
            + '</ul>'
            + '<div class="jp-volume-bar">'
            + '<div class="jp-volume-bar-value"></div>'
            + '</div>'
            + '<ul class="jp-toggles">'
            + '<li><button class="jp-full-screen" title="full screen">full screen</button></li>'
            + '<li><button class="jp-restore-screen" title="restore screen">restore screen</button></li>'
            + '<li><button class="jp-captions" title="captions">show captions</button></li>'
            + '<li><button class="jp-captions-off" title="captions off">hide captions</button></li>'
            + '<li><button class="jp-repeat" title="repeat">repeat video</button></li>'
            + '<li><button class="jp-repeat-off" title="repeat off">repeat off</button></li>'
            + '</ul>'
            + '</div>';
   if (this.title) {
      markup += '<div class="jp-title">'
            + '<ul>'
            + '<li>' + this.title + '</li>'
            + '</ul>'
            + '</div>';
   }

   markup += '</div>'
            + '</div>'
            + '<div class="jp-no-solution">'
            + '<span>Update Required</span>'
            + 'To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.'
            + '</div>'
            + '</div>';

   this.$container.addClass('jp-video jp-video-360p');
   this.$container.append(markup);

} // end addMarkup()

// Function createInstance() creates an instance of the jplayer with the specfied paramaters
//
// @params N/A
//
// @return N/A
//
citesplayer.prototype.createInstance = function() {
   var playerid = this.$container.find('.jp-jplayer').attr('id'); // element to attache the player instance to.
   var thisObj = this; // store the this object

   jQuery('#' + playerid).jPlayer({
      ready: function () {
         jQuery(this).jPlayer("setMedia", {
            m4v: thisObj.mp4,
            ogv: thisObj.ogv,
            webmv: thisObj.webm,
            poster: thisObj.poster
         });
      },
      play: function() { // to avoid both instances playing together.
         jQuery(this).jPlayer("pauseOthers");
      },
      timeupdate: function(event) {
         // Override the timeupdate function to display captions (if we have captions)
         if (thisObj.bCaptionsLoaded) {
            var newTime = Math.round(event.jPlayer.status.currentTime*100)/100; // get the current time, rounded to hundreths
            var bUpdate = false; // true if updating caption display
            var curEvent = thisObj.objEvents[thisObj.ndx]; // the currently display caption event

            // If the new time falls within a caption, set the update flag
            if (newTime >= curEvent.begin && newTime <= curEvent.end) {
               bUpdate = true;
            }
            else if (newTime < curEvent.begin) { // newTime is before the begin time current event

               // loop backwards while newTime is less than the start time of an event (or we have no event)
               while ((newTime < thisObj.objEvents[thisObj.ndx].begin) && thisObj.ndx > 0) {
                  thisObj.ndx--;
               }

               // If newTime does not fall within an event, clear display
               if (newTime < thisObj.objEvents[thisObj.ndx].begin || newTime > thisObj.objEvents[thisObj.ndx].end) {
                  thisObj.$caption.empty();
                  return;
               }

               // Set the update flag
               bUpdate = true;
            }
            else if (newTime > curEvent.end) { // newTime is after the end of the current event

               // loop forward while newTime is greater than an event end (or we have no event)
               while (newTime > thisObj.objEvents[thisObj.ndx].end && thisObj.ndx < thisObj.objEvents.length - 1) {
                  thisObj.ndx++;
               }

               // if newTime does not fall within the current event, clear the display
               if (newTime < thisObj.objEvents[thisObj.ndx].begin || newTime > thisObj.objEvents[thisObj.ndx].end) {
                  thisObj.$caption.empty();
                  return;
               }

               // set the update flag
               bUpdate = true;
            }

            // if the update flag is set, display the currently selected event
            if (bUpdate) {
               thisObj.$caption.html(thisObj.objEvents[thisObj.ndx].text);
            }
         }
      },
      swfPath: g_swfPath,
      supplied: thisObj.suppliedVideo,
      cssSelectorAncestor: '#' + thisObj.$container.attr('id'),
      size: {
         width: "640px",
         height: "360px",
         cssClass: "jp-video-360p"
      }
   });
} // End createInstance()

// Function requestCaptions() makes an ajax request for the specified url.
// If successful, bCaptionsLoaded is set to true.
//
// @param(fpath string) fpath is the url of the file to request
//
// @return N/A
//
citesplayer.prototype.requestCaptions = function(fpath) {
   var thisObj = this;

   // Make a $.get() request for the file and build an array of event objects
   jQuery.when(jQuery.get(fpath,
      function(data) {
         //data = thisObj.decodeHtml(data);
         // Find all the caption events (wrapped in <p> tags)
         var $events = jQuery(data).find('p');

         // For each event, create an event object and push onto the event array
         $events.each(function() {
            // Build the event object
            var curEvent = {
                  begin: thisObj.toSeconds(jQuery(this).attr('begin')),
                  end: thisObj.toSeconds(jQuery(this).attr('end')),
                  text: jQuery(this).text().replace(/\|/g, "<br/>") // replace pipe characters with break tags
            };

            // Push this event onto the events array
            thisObj.objEvents.push(curEvent);
         });
      }
   )).done(function() {
      // The ajax request finished. Check that caption events were found
      if (thisObj.objEvents.length > 0) {
         // We have captions, set bCaptionsLoaded and show the captions control
         
         thisObj.bCaptionsLoaded = true;

         // bind a click event handler
         thisObj.$captionControls.click(function(e) {
            thisObj.$caption.toggle();
            return true;
         });
      }
      else {
         // We do not have captions, remove the caption controls
         thisObj.$captionControls.parent().remove();
      }
   });

} // End requestCaptions()

// Function decodeHtml() converts data encoded by PHP's htmlspecialchars() method back into standard html
//
// @params N/A
//
// @return string
//
citesplayer.prototype.decodeHtml = function(data) {
  return jQuery('<div></div>').html(data).text();
} // End decodeHtml()

// Function toSeconds() converts a time in hours to total number of seconds. This function assumes non-drop time format
//
// @params(time string) time to be converted to seconds.
//
// @return(int) Returns time converted to total number of seconds.
//
citesplayer.prototype.toSeconds = function(time) {
   var tokens = time.split(":");

   return (tokens[0]*3600 + tokens[1]*60 + tokens[2]*1);
} // End toSeconds()
