$(document).ready(
  function() {

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
  
  } // end ready function

)  // end ready event

$(window).resize(
  function() {

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
  
  } // end ready function

)

//
// Source code generators
// 

function SourceCode() {
  this.location = new Array();
  this.code = new Array();
}

/**
 * @member sourcCode
 * @return none
 */

SourceCode.prototype.add = function( location_id, code_id ) {
  this.location.push(location_id);
  this.code.push(code_id);
}

/**
 * @member sourcCode
 * @return none
 */

SourceCode.prototype.make = function() {

   var node_code;
   var node_location;

   for(var i = 0; i < this.location.length; i++ ) {
     
     node_location = document.getElementById( this.location[i] );
     node_code     = document.getElementById( this.code[i] );
     
     node_location.className = "code";
     this.createCode( node_location, "", node_code );
     
   } // endfor
     
}

SourceCode.prototype.createCode = function( location, spaces, node ) {

  var i;

  var node_name = node.nodeName.toLowerCase();

  location.innerHTML = location.innerHTML + "<br/>" + spaces  + "&lt;" + node_name;
  
  for(i=0; i < node.attributes.length; i++ ) {
  
    location.innerHTML = location.innerHTML + "&nbsp;" + node.attributes[i].nodeName + "=\"";
    location.innerHTML = location.innerHTML + node.attributes[i].nodeValue + "\"";
     
    if ( ((i + 1) != node.attributes.length) && (node.attributes.length > 2 ) ) {

      location.innerHTML = location.innerHTML + "<br/>" + spaces;
        
      for(var j=0; j <= node_name.length; j++ ) {
        location.innerHTML = location.innerHTML + "&nbsp;";   
      }  // endfor
    } // endif
  }  // endfor
  
  location.innerHTML = location.innerHTML + "&gt;";

  var count = 0;

  for(i=0; i < node.childNodes.length; i++ ) {
  
    switch( node.childNodes[i].nodeType ) {
    
      case Node.ELEMENT_NODE:

         this.createCode( location, spaces + "&nbsp;&nbsp;", node.childNodes[i]);
           count++;
         break;

      case Node.TEXT_NODE:
      
         var text = trim(node.childNodes[i].nodeValue);
         
         if (text.length) location.innerHTML = location.innerHTML + "<br/>" + spaces + "&nbsp;&nbsp;" + text;
           count++;
         break;
    }  // end switch
  

  } // end for

  if( count > 0 ) { 
    location.innerHTML = location.innerHTML + "<br/>" + spaces + "&lt;/" + node.nodeName.toLowerCase() + "&gt;";
  } // end if

}

function trim(s) {
	s = s.replace(/(^\s*)|(\s*$)/gi,"");
	s = s.replace(/[ ]{2,}/gi," ");
	s = s.replace(/\n /,"\n");
	return s;
}

var sourceCode = new SourceCode();

function slideShowURL() {
  var link = window.location.href
  link = link.substr(0,link.lastIndexOf('/'))
  document.write('<p class="slide-show-url">Slides at:<br/><a href="' + link + '">' + link + '</a></p>')
}
