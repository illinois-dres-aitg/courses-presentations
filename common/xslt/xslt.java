/*
 * Generates an implementation report for UAAG
 *
 * Copyright (c) 2001 Jon Gunderson  All rights reserved.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.  IN NO EVENT SHALL THE APACHE SOFTWARE FOUNDATION OR
 * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * ====================================================================
 *
 */

// Imported TraX classes
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerConfigurationException;


// Imported java classes
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.*;
import java.util.*;
import java.io.*;

// Imported SAX classes
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;

// FileIOApp
import java.lang.System;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.File;
import java.io.IOException;


// ************************************************************
//
// Stylesheet transformation
//
// ************************************************************

public class xslt
{
	public static void main(String[] args)
    throws TransformerException, TransformerConfigurationException, 
           FileNotFoundException, IOException
  {  

      if( args.length == 3 ) {
	  
	  TransformerFactory tFactory = TransformerFactory.newInstance();

	  // Use the TransformerFactory to instantiate a Transformer that will work with  
	  // the stylesheet you specify. This method call also processes the stylesheet
	  // into a compiled Templates object.

	  Transformer transformer = tFactory.newTransformer(new StreamSource(args[1]));

	  // Use the Transformer to apply the associated Templates object to an XML document
	  System.out.println("Transforming: " + args[0] );
	  System.out.println("To: " + args[2] );
	  System.out.println("Using: " + args[1] );
	  System.out.println();

	  transformer.transform(new StreamSource(args[0]), new StreamResult(new FileOutputStream(args[2])));
	
      } else {

	  System.out.println("java xslt filename.xml filename.xsl filename.xml\n");

      }

  }

}

