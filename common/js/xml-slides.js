function resizeContent() {

    $('#content').css('marginBottom', 4);

    var index_height     = $('#index').height();
    var content_height   = $('#content').innerHeight();
    var copyright_height = $('#copyright').height();
    var document_height  = $(document).height();

    var space = document_height - index_height - copyright_height - content_height - 120;

    // resize HTML Slide to fit window
    if( document_height > space) {

        $('#content').css('marginBottom', space);

    }

};

$(document).ready(function() {

    // hide content with the more class
    $('.more').css('display', 'none');
    $('#content').css('display', 'none');
    $('#content').fadeIn('slow');

    resizeContent()

});  // end ready event

$(document).keydown(function( event ) {
  var found      = false;
  var allVisible = true;
  var allHidden  = true;

  if ( ( event.which == 32 && !event.shiftKey ) || (event.which == 40)) {
    $('.more').each(function() {
      if (!found && $(this).css('display') === 'none') {
        $(this).fadeIn();
        found = true;
        resizeContent();
      }
    })

    if (found) {
      event.preventDefault();
    }
  }

  if ( ( event.which == 32 && event.shiftKey ) || (event.which == 38)) {
    $($('.more').get().reverse()).each(function() {
      if (!found && $(this).css('display') !== 'none') {
        $(this).fadeOut('slow', resizeContent);
        found = true;
      }
    })

    if (found) {
      event.preventDefault();
    }
  }

  if ( event.shiftKey && (event.which == 40)) {
    $('.more').each(function() {
      allVisible = allVisible && ($(this).css('display') !== 'none');
    })

    if (!allVisible) {
      $('.more').fadeIn();
      event.preventDefault();
    }
  }

  if ( event.shiftKey && (event.which == 38)) {
    $('.more').each(function() {
      allHidden = allHidden && ($(this).css('display') === 'none');
    });

    if (!allHidden) {
      $('.more').fadeOut();
      event.preventDefault();
    }
  }

  if ( !event.ctrlKey && !event.altKey && event.which == 37 ) {
    if (event.shiftKey) {
      $('a#ID_SLIDE_FIRST').get(0).click();
    }
    else {
      $('a#ID_SLIDE_PREVIOUS').get(0).click();
    }
    event.preventDefault();
  }

  if ( !event.ctrlKey && !event.altKey && event.which == 39 ) {
    if (event.shiftKey) {
      $('a#ID_SLIDE_LAST').get(0).click();
    }
    else {
      $('a#ID_SLIDE_NEXT').get(0).click();
    }
    event.preventDefault();
  }


});


$(window).resize(
  function() {
    resizeContent()
  } // end ready function

)

/**
 * @constructor SourceCode
 *
 * @desc  Creates source code of an example
 *
 * @property  location      Array  -  Object containing the keyCodes used by the slider widget
 * @property  code          Array  -  JQuery node object
 */

SourceCode = function () {
  this.location = new Array();
  this.code = new Array();
};

/**
 * @method add
 *
 * @desc  Adds source code
 */

SourceCode.prototype.add = function (locationId, codeId) {
  this.location[this.location.length] = locationId;
  this.code[this.code.length] = codeId;
};

/**
 * @method make
 *
 * @desc  Generates HTML content for source code
 */

SourceCode.prototype.make = function () {

  var nodeCode;
  var nodeLocation;

  for (var i = 0; i < this.location.length; i++) {

    nodeLocation = document.getElementById(this.location[i]);
    nodeCode = document.getElementById(this.code[i]);

    nodeLocation.className = 'sourcecode';
    this.createCode(nodeLocation, '', nodeCode, true);

  } // endfor

};

/**
 * @method createCode
 *
 * @desc  Specify the source code and the location of the source code
 *
 * @param  location   String   - id of element to put the source code
 * @param  spaces     String   - Any spaces to precede the source code
 * @param  node       Object   - DOM Element node to use to generate the source code
 */

SourceCode.prototype.createCode = function (location, spaces, node, first) {

  function hasText (s) {
    if (typeof s !== 'string') {return false;}

    for (var i = 0; i < s.length; i++) {
      var c = s[i];
      if (c !== ' ' && c !== '\n' && c !== '\r') {return true;}
    }
    return false;
  }

  function cleanText (s) {
    if (typeof s !== 'string') {return '';}

    s1 = '';
    for (var i = 0; i < s.length; i++) {
      var c = s[i];

      if (c === '<') {
        c = '&lt;';
      }

      if (c === '>') {
        c = '&gt;';
      }

      s1 += c;
    }
    return s1;
  }

  var i, s;
  var count = 0;

  if (typeof first !== 'boolean') {
    first = false;
  }

  if (!first) {
    var nodeNameStr = node.nodeName.toLowerCase();

    location.innerHTML = location.innerHTML + '<br/>' + spaces + '&lt;' + nodeNameStr;

    for (i = 0; i < node.attributes.length; i++) {

      location.innerHTML = location.innerHTML + '&nbsp;' + node.attributes[i].nodeName + '="';
      location.innerHTML = location.innerHTML + node.attributes[i].value + '"';

      if (((i + 1) != node.attributes.length) && (node.attributes.length > 2)) {

        location.innerHTML = location.innerHTML + '<br/>' + spaces;

        for (var j = 2; j <= nodeNameStr.length; j++) {
          location.innerHTML = location.innerHTML + '&nbsp;';
        }

      } // endif

    } // endfor

    location.innerHTML = location.innerHTML + '&gt;';
  }

  for (i = 0; i < node.childNodes.length; i++) {

    var n = node.childNodes[i];

    switch (n.nodeType) {

      case Node.ELEMENT_NODE:
        this.createCode(location, spaces + '&nbsp;&nbsp;', n);
        count++;
        break;

      case Node.TEXT_NODE:
        if (hasText(n.nodeValue)) {
          s = cleanText(n.nodeValue);
          location.innerHTML = location.innerHTML + '<br/>' + spaces + '&nbsp;&nbsp;' + s;
        }
        count++;
        break;

      case Node.COMMENT_NODE:

        if (hasText(n.nodeValue)) {
          location.innerHTML = location.innerHTML  + '<br/>' + spaces + '&nbsp;&nbsp;' + '&lt;--&nbsp;&nbsp;' + n.nodeValue + '--&gt;';
        }
        count++;
        break;

    } // end switch

  } // end for

  if (!first) {
    if (count > 0) {
      location.innerHTML = location.innerHTML + '<br/>' + spaces + '&lt;/' + node.nodeName.toLowerCase();
      location.innerHTML = location.innerHTML + '&gt;';
    } // end if
  }

};

var sourceCode = new SourceCode();

function slideShowURL() {
  var link = window.location.href
  link = link.substr(0,link.lastIndexOf('/'))
  document.write('<p class="slide-show-url">Slides at:<br/><a href="' + link + '">' + link + '</a></p>')
}


