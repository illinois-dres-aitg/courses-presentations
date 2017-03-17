<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:wai_report="http://www.w3.org/wai"
                version="1.0"
    xmlns:lxslt="http://xml.apache.org/xslt"
    xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
    extension-element-prefixes="redirect">

  <xsl:output method="html" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"/>

  <xsl:template match="/">

    <xsl:element name="html">
      <xsl:attribute name="lang"><xsl:value-of select="/slides/lang/."/></xsl:attribute>
  
      <xsl:element name="head">
        <xsl:element name="title"><xsl:value-of select="/slides/title/."/></xsl:element>
  
        <xsl:if test="/slides/stylesheet">
          <xsl:element name="link">
             <xsl:attribute name="rel">stylesheet</xsl:attribute>
            <xsl:attribute name="type">text/css</xsl:attribute>
            <xsl:attribute name="href"><xsl:value-of select="/slides/stylesheet/."/></xsl:attribute>
          </xsl:element>
        </xsl:if>
  
        <xsl:for-each select="/slides/stylesheets/stylesheet">
          <xsl:element name="link">
             <xsl:attribute name="rel"><xsl:value-of select="./rel"/></xsl:attribute>
            <xsl:attribute name="type">text/css</xsl:attribute>
            <xsl:attribute name="title"><xsl:value-of select="./title"/></xsl:attribute>
            <xsl:attribute name="href"><xsl:value-of select="./href"/></xsl:attribute>
          </xsl:element>
        </xsl:for-each>
  
        <xsl:for-each select="/slides/script">
          <xsl:element name="script">
            <xsl:attribute name="type">text/javascript</xsl:attribute>
            <xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
          </xsl:element>
        </xsl:for-each>
  
      </xsl:element>
  
      <xsl:element name="body">
  
        <xsl:element name="div">
          <xsl:attribute name="class">title_nav</xsl:attribute>
  
          <xsl:call-template name="navbar">
            <xsl:with-param name="num"   select="0" />
            <xsl:with-param name="total" select="count(/slides/slide)" />
          </xsl:call-template>
  
        </xsl:element>
  
        <xsl:element name="div">
          <xsl:attribute name="role">main</xsl:attribute>
          <xsl:attribute name="id">content</xsl:attribute>
  
          <xsl:element name="h1">
            <xsl:value-of select="slides/title"/>
          </xsl:element>
  
  
          <xsl:element name="p">
            <xsl:attribute name="class">name</xsl:attribute>
            <xsl:if test="/slides/name/.">
              <xsl:value-of select="/slides/name/."/>
            </xsl:if>
          </xsl:element>
  
          <xsl:if test="/slides/phone/.">
            <xsl:element name="p">
              <xsl:attribute name="class">phone</xsl:attribute>
              <xsl:value-of select="/slides/phone/."/>
            </xsl:element>
          </xsl:if>
  
          <xsl:if test="/slides/email/.">
            <xsl:element name="p">
              <xsl:attribute name="class">email</xsl:attribute>
              <xsl:value-of select="/slides/email/."/>
            </xsl:element>
          </xsl:if>
  
          <xsl:if test="/slides/www/.">
            <xsl:element name="p">
              <xsl:attribute name="class">email</xsl:attribute>
              WWW: 
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:value-of select="/slides/www/@href"/>
                </xsl:attribute> 
                <xsl:value-of select="/slides/www/."/>
              </xsl:element>
            </xsl:element>
          </xsl:if>
  
          <xsl:for-each select="/slides/desc">
            <xsl:element name="p">
              <xsl:attribute name="class">desc</xsl:attribute>
              <xsl:choose>
                <xsl:when test="@href">
                  <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>                          
                    <xsl:value-of select="."/>
                  </xsl:element>                              
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="."/>                            
                </xsl:otherwise>
              </xsl:choose>                        
            </xsl:element>
          </xsl:for-each>
                      
  
          <xsl:element name="h2">
            <xsl:attribute name="class">index</xsl:attribute>Slides
          </xsl:element>
  
          <xsl:element name="ol">
  
          <xsl:for-each select="/slides/slide">
            <xsl:element name="li">
              <xsl:attribute name="class">index</xsl:attribute>
              <xsl:element name="a">
                <xsl:attribute name="href">slide<xsl:value-of select="position()"/>.html</xsl:attribute>
                <xsl:attribute name="class">index</xsl:attribute>
                <xsl:value-of select="title/."/>
              </xsl:element>
            </xsl:element>
          </xsl:for-each>
  
          </xsl:element>
        </xsl:element>
       </xsl:element>
    </xsl:element>
  
    <xsl:for-each select="/slides/slide" >
  
      <xsl:variable name="fname">slide<xsl:value-of select="position()"/>.html</xsl:variable>
  
      <redirect:write select="$fname">
  
        <xsl:element name="html">
          <xsl:attribute name="lang"><xsl:value-of select="/slides/lang/."/></xsl:attribute>
  
          <xsl:element name="head">
            <xsl:element name="title">
              <xsl:text>Slide </xsl:text><xsl:value-of  select="position()"/><xsl:text>: </xsl:text>
              <xsl:value-of select="title/."/>
            </xsl:element>
  
            <xsl:if test="/slides/stylesheet">
               <xsl:element name="link">
                 <xsl:attribute name="rel">stylesheet</xsl:attribute>
                 <xsl:attribute name="type">text/css</xsl:attribute>
                 <xsl:attribute name="href"><xsl:value-of select="/slides/stylesheet/."/></xsl:attribute>
               </xsl:element>
            </xsl:if>
  
            <xsl:for-each select="/slides/stylesheets/stylesheet">
               <xsl:element name="link">
                 <xsl:attribute name="rel"><xsl:value-of select="./rel"/></xsl:attribute>
                 <xsl:attribute name="type">text/css</xsl:attribute>
                 <xsl:attribute name="title"><xsl:value-of select="./title"/></xsl:attribute>
                 <xsl:attribute name="href"><xsl:value-of select="./href"/></xsl:attribute>
               </xsl:element>
             </xsl:for-each>
  
            <xsl:for-each select="/slides/script">
              <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
              </xsl:element>
            </xsl:for-each>
  
            <xsl:if test="stylesheet/.">
              <xsl:element name="link">
                <xsl:attribute name="rel">stylesheet</xsl:attribute>
                <xsl:attribute name="type">text/css</xsl:attribute>
                <xsl:attribute name="href"><xsl:value-of select="stylesheet/."/></xsl:attribute>
              </xsl:element>
            </xsl:if>
  
            <xsl:if test="style/.">
              <xsl:element name="style">
                <xsl:attribute name="type">text/css</xsl:attribute>
                <xsl:value-of select="style/."/>
              </xsl:element>
            </xsl:if>
  
            <xsl:for-each select="scriptref">
              <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
              </xsl:element>
            </xsl:for-each>
                    
            <xsl:if test="script/.">
              <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:value-of select="script/."/>
              </xsl:element>
            </xsl:if>
  
            <xsl:if test="meta">
             <xsl:element name="meta">
               <xsl:attribute name="http-equiv"><xsl:value-of select="meta/@http-equiv"/></xsl:attribute>
               <xsl:attribute name="content"><xsl:value-of select="meta/@content"/></xsl:attribute>
             </xsl:element>
            </xsl:if>
          </xsl:element>
  
          <xsl:element name="body">
  
            <xsl:call-template name="navbar">
              <xsl:with-param name="num"   select="position()" />
              <xsl:with-param name="total" select="last()" />
            </xsl:call-template>
  
            <xsl:element name="div">
              <xsl:attribute name="role">main</xsl:attribute>
              <xsl:attribute name="id">content</xsl:attribute>
                <xsl:element name="a">
                  <xsl:attribute name="name">main</xsl:attribute>
                  <xsl:attribute name="id">main</xsl:attribute>
                </xsl:element>
  
              <xsl:if test="title/.">
                <xsl:element name="h1">
                  <xsl:attribute name="id">h1_title</xsl:attribute>
                  <xsl:attribute name="class">title</xsl:attribute>
                  <xsl:value-of select="title/."/>
                </xsl:element>
              </xsl:if>
  
              <xsl:apply-templates select="contents/*"/>
  
            </xsl:element>
  
            <xsl:element name="div">
              <xsl:attribute name="role">contentinfo</xsl:attribute>
              <xsl:attribute name="id">copyright</xsl:attribute>
              Copyright 2015 University of Illinois
            </xsl:element>
          </xsl:element>
        </xsl:element>

      </redirect:write>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*">
   
    <xsl:copy>
      <xsl:for-each select="@*">
         <xsl:copy/>
      </xsl:for-each>

      <xsl:apply-templates />
    </xsl:copy>

  </xsl:template>
              
  <xsl:template name="navbar" >
     <xsl:param name="num" select="'0'"/>
     <xsl:param name="total" select="'0'"/>

     <xsl:variable name="previous">slide<xsl:value-of select="$num - 1"/>.html</xsl:variable>
     <xsl:variable name="next">slide<xsl:value-of select="$num + 1"/>.html</xsl:variable>
     <xsl:variable name="last">slide<xsl:value-of select="$total"/>.html</xsl:variable>

     <xsl:element name="div">
       <xsl:attribute name="id">index</xsl:attribute>
       <xsl:attribute name="role">navigation</xsl:attribute>
       
        <xsl:element name="a">
            <xsl:attribute name="name">nav</xsl:attribute>
            <xsl:attribute name="id">nav</xsl:attribute>
        </xsl:element>

        <xsl:element name="h2">
           <xsl:attribute name="class">hidden</xsl:attribute>
           Slide Navigation
        </xsl:element>

        <xsl:element name="ul">
          <xsl:attribute name="class">slide_nav</xsl:attribute>
          <xsl:attribute name="title">Slide Navigation Menu</xsl:attribute>

          <xsl:if test="position() > 0">
            <xsl:element name="li">
              <xsl:attribute name="class">slide_num</xsl:attribute>
              <xsl:text>Slide </xsl:text> 
              <xsl:value-of select="position()"/>
              <xsl:text> of </xsl:text> 
              <xsl:value-of select="last()"/>
            </xsl:element>
          </xsl:if>

           <xsl:choose>
             <xsl:when test="$num=0"> 
               <xsl:element name="li">Index</xsl:element>
             </xsl:when> 
             <xsl:otherwise> 
               <xsl:element name="li">
                 <xsl:element name="a">
                   <xsl:attribute name="href">index.html</xsl:attribute>Index
                 </xsl:element>
               </xsl:element>
             </xsl:otherwise> 
           </xsl:choose>

           <xsl:element name="li">
              <xsl:element name="a">
                 <xsl:attribute name="href">slide1.html</xsl:attribute>First
              </xsl:element>
           </xsl:element>

           <xsl:choose>
             <xsl:when test="$num>1">
               <xsl:element name="li">
                 <xsl:element name="a">
                   <xsl:attribute name="href"><xsl:value-of select="$previous"/></xsl:attribute>Previous
                 </xsl:element>
               </xsl:element>
             </xsl:when>
              <xsl:otherwise>
                 <xsl:element name="li">Previous</xsl:element>
              </xsl:otherwise>
           </xsl:choose>
           
           <xsl:choose>
             <xsl:when test="$num=0">
               <xsl:element name="li">
                 <xsl:element name="a">
                   <xsl:attribute name="href"><xsl:value-of select="$next"/></xsl:attribute>Next
                 </xsl:element>
               </xsl:element>
               <xsl:element name="li">
                  <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="$last"/></xsl:attribute>Last
                  </xsl:element>
                </xsl:element>
             </xsl:when>

             <xsl:when test="$num&lt;$total">
                <xsl:element name="li">
                  <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="$next"/></xsl:attribute>Next
                  </xsl:element>
                </xsl:element>
                <xsl:element name="li">
                  <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="$last"/></xsl:attribute>Last
                  </xsl:element>
                </xsl:element>
             </xsl:when>

             <xsl:otherwise>
                <xsl:element name="li">Next</xsl:element>
                <xsl:element name="li">Last</xsl:element>
             </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
     </xsl:element>

  </xsl:template>
</xsl:stylesheet>






