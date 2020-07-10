function resizeContent() {

    $('#content').css('marginBottom', 4);

    var nav_height         = $('#nav').height();
    var content_height     = $('#content').innerHeight();
    var transcript_height  = $('aside[aria-label]').innerHeight();
    if (!transcript_height) {
      transcript_height = 0;
    }
    var copyright_height = $('footer').height();
    var document_height  = $(document).height();

    var space = document_height - nav_height - (1.5 * copyright_height) - transcript_height - content_height;

    // resize HTML Slide to fit window
    if( document_height > space) {
        $('#content').css('marginBottom', space + 'px');
    }

};

function showMore() {
  var found = false;
  $('.more').each(function() {
    if (!found && $(this).css('display') === 'none') {
      $(this).fadeIn();
      found = true;
      resizeContent();
    }
  })
  return found;
}

function showLess() {
  var found = false;
  $($('.more').get().reverse()).each(function() {
    if (!found && $(this).css('display') !== 'none') {
      $(this).fadeOut('slow', resizeContent);
      found = true;
    }
  })
  return found;
}

$(document).ready(function() {

    // hide content with the more class
    $('.more').css('display', 'none');
    $('#content').css('display', 'none');
    $('#content').fadeIn('slow');


    var html = '<div style="position: relative; top: -0.5em;">';
    html += '<button type="button" onclick="showMore()" class="btn btn-default" aria-label="Show Next"><span class="glyphicon glyphicon-arrow-down"  aria-hidden="true"></span></button>';
    html += '<button type="button" onclick="showLess()" class="btn btn-default" aria-label="Hide Last"><span class="glyphicon glyphicon-arrow-up"    aria-hidden="true"></span></button>';
    html += '</div>';

    if ($('.more').length) {
//      $('#slide-nav').first().append(html);
    }

    resizeContent()


});  // end ready event

$(document).ready(function() {

  function transcriptNode(node) {

    function addPhrase(i, j) {

      var k, html='';

      if (j <= 0 || (i === j)) {
        return '';
      }

      var phrase = transcriptText.substring(i, j+1).trim();
      if (phrase.length) {

        k = phrase.indexOf('[');
        l = phrase.indexOf(']');

        if ( k >= 0 && l > 0) {
          phrase = '<span class="name">' + phrase.substring(k, l+1) + '</span>' + phrase.substring(l+1, phrase.length);
        }

        html += '<div class="phrase">\n';
        html += phrase;
        html += '\n</div>\n';
      }

      return html;

    }

    function getNextPhraseIndex(start) {



      function ignoreCharacter(c) {
        return " \n\r".indexOf(c) >= 0;
      }

      var index = start;
      var spaceCount = 0;
      var isLastCharANumber = false;
      var c = '';
      var c1 = '';
      var c2 = '';
      var parenCount = 0;

      while (ignoreCharacter(transcriptText[index]) &&
             (index < transcriptTextLength)) {
        index++;
      }

      while (index < transcriptTextLength) {

        c1 = c;
        c = transcriptText[index];
        if (index < (transcriptTextLength-1)) {
          c2 = transcriptText[index+1]
        }
        else {
          c2 = '';
        }

        if ('([{'.indexOf(c) >= 0) {
          parenCount += 1;
        }

        if (')]}'.indexOf(c) >= 0) {
          parenCount -= 1;
        }

        if (c === ' ') {
          spaceCount += 1;
        }

        isLastCharANumber = '0123456789'.indexOf(c1) >= 0;
        isNextCharANumber = '0123456789'.indexOf(c2) >= 0;

        if (('?!'.indexOf(c) >= 0) && !parenCount) {
          return index;
        }

        if (c === ':' && (spaceCount > 1) && !parenCount) {
          return index;
        }

        if (c === '.' &&
            (!isLastCharANumber || spaceCount) &&
            !(isLastCharANumber && isNextCharANumber) &&
            !parenCount) {
          return index;
        }

        index += 1;
      }

      return transcriptTextLast;

    }

    var transcriptHTML = '';
    var transcriptText = node.textContent.trim();
    var transcriptTextLength = transcriptText.length;
    var transcriptTextLast   = transcriptTextLength-1;

    var index1 = 0;
    var index2 = getNextPhraseIndex(0);

    while (index2 < transcriptTextLast) {
      transcriptHTML += addPhrase(index1, index2);
      index1 = index2+1;
      index2 = getNextPhraseIndex(index1);
    }
    transcriptHTML += addPhrase(index1, index2);

    $(node).html(transcriptHTML);


  }

  var fullTranscriptNodes = document.querySelectorAll('.full-transcript');
  var slideTranscriptNodes = document.querySelectorAll('.slide-transcript');

  fullTranscriptNodes.forEach( function(node) {
    transcriptNode(node);
  });

  slideTranscriptNodes.forEach( function(node) {
    transcriptNode(node);
  });

  $('details.transcript').change(function() {
    alert( "Handler for .change() called." );
  });

});  // end ready event

$(document).keydown(function( event ) {
  var found      = false;
  var allVisible = true;
  var allHidden  = true;

  if ( ( event.which == 32 && !event.shiftKey ) || (event.which == 40)) {

    found = showMore();

    if (found) {
      event.preventDefault();
    }
  }

  if ( ( event.which == 32 && event.shiftKey ) || (event.which == 38)) {

    found = showLess();

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

  if (event.ctrlKey) {
    $('main').addClass('highlight');
  }

});

$(document).keyup(function( event ) {
  if (!event.ctrlKey) {
    $('main').removeClass('highlight');
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
//  link = link.substr(0,link.lastIndexOf('/'))
  document.write('<p class="slide-show-url">Current slide URL:<br/><a href="' + link + '">' + link + '</a></p>')
}


function closeWindow() {
  window.close();
}
