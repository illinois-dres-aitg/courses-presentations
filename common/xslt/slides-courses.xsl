<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:wai_report="http://www.w3.org/wai"
                version="1.0"
    xmlns:lxslt="http://xml.apache.org/xslt"
    xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
    extension-element-prefixes="redirect">

  <xsl:output method="html" doctype-public="" indent="yes"/>

  <xsl:template match="/">

    <xsl:element name="html">
      <xsl:attribute name="lang"><xsl:value-of select="/slides/lang/."/></xsl:attribute>

      <xsl:element name="head">

        <xsl:element name="title"><xsl:value-of select="/slides/title/."/></xsl:element>

        <xsl:call-template name="head">
        </xsl:call-template>


      </xsl:element>

      <xsl:element name="body">

        <xsl:call-template name="navbar">
          <xsl:with-param name="num"   select="0" />
          <xsl:with-param name="total" select="count(/slides/slide)" />
        </xsl:call-template>



        <xsl:element name="main">
          <xsl:attribute name="class">container</xsl:attribute>
          <xsl:attribute name="id">content</xsl:attribute>

          <xsl:if test="/slides/home/.">
            <xsl:element name="p">
              <xsl:attribute name="class">btn btn-default home</xsl:attribute>
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:value-of select="/slides/home/."/>
                </xsl:attribute>
                Home
              </xsl:element>
            </xsl:element>
          </xsl:if>

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

          <xsl:for-each select="/slides/person">
            <xsl:call-template name="person">
            </xsl:call-template>
          </xsl:for-each>

          <xsl:for-each select="/slides/conference">
            <xsl:call-template name="conference">
            </xsl:call-template>
          </xsl:for-each>

          <xsl:for-each select="/slides/desc">
            <xsl:call-template name="desc">
            </xsl:call-template>
          </xsl:for-each>


          <xsl:if test="/slides/email/.">
            <xsl:element name="p">
              <xsl:attribute name="class">email</xsl:attribute>
              E-mail:
              <xsl:element name="a">
                <xsl:attribute name="href">mailto:<xsl:value-of select="/slides/email/."/></xsl:attribute>
                <xsl:value-of select="/slides/email/."/>
              </xsl:element>
            </xsl:element>
          </xsl:if>


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
        <xsl:call-template name="contentinfo">
        </xsl:call-template>
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

            <xsl:call-template name="head">
              <xsl:with-param name="style" select = "style/." />
            </xsl:call-template>

          </xsl:element>


          <xsl:element name="body">

            <xsl:call-template name="navbar">
              <xsl:with-param name="num"            select="position()"/>
              <xsl:with-param name="total"          select="last()" />
            </xsl:call-template>

            <xsl:element name="main">
              <xsl:attribute name="id">content</xsl:attribute>
              <xsl:attribute name="class">container</xsl:attribute>

              <xsl:element name="div">
                <xsl:attribute name="class">row</xsl:attribute>

                <xsl:element name="div">
                  <xsl:attribute name="class">col-md-1</xsl:attribute>
                </xsl:element>

                <xsl:element name="div">
                  <xsl:attribute name="class">col-md-9</xsl:attribute>

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
                  <xsl:attribute name="class">col</xsl:attribute>
                </xsl:element>

              </xsl:element>

            </xsl:element>

            <xsl:if test="/slides/addtranscript">

              <xsl:element name="aside">
                <xsl:attribute name="class">container</xsl:attribute>
                <xsl:attribute name="aria-label">Transcript</xsl:attribute>

                <xsl:element name="div">
                  <xsl:attribute name="class">row</xsl:attribute>

                  <xsl:element name="div">
                     <xsl:attribute name="class">col-md-1</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="div">
                      <xsl:attribute name="class">col-md-9</xsl:attribute>

                      <xsl:element name="details">
                        <xsl:attribute name="class">transcript-container</xsl:attribute>

                        <xsl:element name="summary">
                          <xsl:attribute name="id">id-slide-transcript-button</xsl:attribute>
                          <xsl:attribute name="class">btn-primary btn-sm</xsl:attribute>
                          <xsl:attribute name="title">Audio transcript of the portion of the video for this slide</xsl:attribute>
                          Audio Transcript
                        </xsl:element>

                        <xsl:choose>
                          <xsl:when test="transcript">
                            <xsl:element name="div">
                              <xsl:attribute name="class">slide-transcript</xsl:attribute>
                              <xsl:value-of select="transcript"/>
                            </xsl:element>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:element name="div">
                              <xsl:attribute name="class">notranscript</xsl:attribute>
                              No transcript found for this slide.
                            </xsl:element>
                          </xsl:otherwise>
                        </xsl:choose>

                      </xsl:element>
                  </xsl:element>

                  <xsl:element name="div">
                    <xsl:attribute name="class">col</xsl:attribute>
                  </xsl:element>
                </xsl:element>

              </xsl:element>

            </xsl:if>

            <xsl:call-template name="contentinfo">
            </xsl:call-template>

          </xsl:element>
        </xsl:element>

      </redirect:write>

    </xsl:for-each>

    <xsl:if test="/slides/addtranscript">

      <xsl:variable name="fname">transcript.html</xsl:variable>

      <redirect:write select="$fname">

        <xsl:element name="html">
          <xsl:attribute name="lang"><xsl:value-of select="/slides/lang/."/></xsl:attribute>
          <xsl:element name="head">
            <xsl:element name="title">
              <xsl:text>Full Audio Transcription: </xsl:text><xsl:value-of  select="/slides/title"/>
            </xsl:element>

            <xsl:call-template name="head">
              <xsl:with-param name="style" select = "style/." />
            </xsl:call-template>

          </xsl:element>

          <xsl:element name="body">

            <xsl:element name="main">
              <xsl:attribute name="id">content</xsl:attribute>
              <xsl:attribute name="class">container</xsl:attribute>

              <xsl:element name="div">
                <xsl:attribute name="class">row</xsl:attribute>

                <xsl:element name="div">
                  <xsl:attribute name="class">col-md-1</xsl:attribute>
                </xsl:element>

                <xsl:element name="div">
                  <xsl:attribute name="class">col-md-9</xsl:attribute>

                  <xsl:element name="h1">
                    <xsl:attribute name="id">h1_title</xsl:attribute>
                    <xsl:attribute name="class">title</xsl:attribute>
                    Full Audio Transcript for <xsl:value-of select="/slides/title/."/>
                  </xsl:element>

                  <xsl:for-each select="/slides/slide">
                    <xsl:element name="h2">
                      <xsl:element name="a">
                        <xsl:attribute name="id">slide<xsl:value-of select="position()"/></xsl:attribute>
                        <xsl:attribute name="target">slides</xsl:attribute>
                        <xsl:attribute name="href">slide<xsl:value-of select="position()"/>.html</xsl:attribute>
                        Slide <xsl:value-of select="position()"/>:
                        <xsl:value-of select="title/."/>
                      </xsl:element>
                    </xsl:element>

                    <xsl:choose>
                      <xsl:when test="transcript">
                        <xsl:element name="div">
                          <xsl:attribute name="class">full-transcript</xsl:attribute>
                          <xsl:value-of select="transcript/."/>
                        </xsl:element>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:element name="div">
                          <xsl:attribute name="class">notranscript</xsl:attribute>
                          No transcript for this slide.
                        </xsl:element>
                      </xsl:otherwise>
                    </xsl:choose>

                  </xsl:for-each>

                </xsl:element>

                <xsl:element name="div">
                  <xsl:attribute name="class">col</xsl:attribute>
                </xsl:element>

              </xsl:element>

            </xsl:element>

            <xsl:call-template name="contentinfo">
            </xsl:call-template>

          </xsl:element>
        </xsl:element>

      </redirect:write>

    </xsl:if>

  </xsl:template>

  <xsl:template match="*">

    <xsl:copy>
      <xsl:for-each select="@*">
         <xsl:copy/>
      </xsl:for-each>

      <xsl:apply-templates />
    </xsl:copy>

  </xsl:template>

  <xsl:template name="head" >
    <xsl:param name = "style" />

    <xsl:if test="meta">
      <xsl:element name="meta">
        <xsl:attribute name="http-equiv"><xsl:value-of select="meta/@http-equiv"/></xsl:attribute>
        <xsl:attribute name="content"><xsl:value-of select="meta/@content"/></xsl:attribute>
      </xsl:element>
    </xsl:if>

    <xsl:for-each select="/slides/stylesheet">
      <xsl:element name="link">
        <xsl:attribute name="rel">stylesheet</xsl:attribute>
        <xsl:attribute name="type">text/css</xsl:attribute>
        <xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
      </xsl:element>
    </xsl:for-each>

    <xsl:for-each select="/slides/script">
      <xsl:element name="script">
        <xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
      </xsl:element>
    </xsl:for-each>

      <xsl:element name="style">
        <xsl:attribute name="id">style</xsl:attribute>
        <xsl:value-of select="$style"/>
      </xsl:element>

  </xsl:template>

  <xsl:template name="contentinfo" >
    <xsl:element name="footer">
      <xsl:attribute name="class">container</xsl:attribute>

      <xsl:element name="div">
        <xsl:attribute name="id">footer</xsl:attribute>
        <xsl:attribute name="class">well well-sm</xsl:attribute>
        <xsl:element name="a">
          <xsl:attribute name="href">http://illinois.edu</xsl:attribute>
          <xsl:attribute name="target">illinois</xsl:attribute>
          <xsl:element name="img">
            <xsl:attribute name="src">https://aitg.disability.illinois.edu/common/images/block-i.png</xsl:attribute>
            <xsl:attribute name="alt">University of Illinois</xsl:attribute>
          </xsl:element>
        </xsl:element>
        Copyright &#169; 2020 University of Illinois
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template name="desc" >
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
  </xsl:template>

  <xsl:template name="person" >
    <xsl:element name="div">
      <xsl:attribute name="class">person</xsl:attribute>
      <xsl:if test="./name">
        <xsl:element name="p">
          <xsl:attribute name="class">name</xsl:attribute>
          <xsl:value-of select="./name"/>
        </xsl:element>
      </xsl:if>
      <xsl:for-each select="./desc">
        <xsl:call-template name="desc">
        </xsl:call-template>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template name="conference" >
    <xsl:element name="div">
      <xsl:attribute name="class">conference</xsl:attribute>

      <xsl:if test="./name">
        <xsl:element name="p">
          <xsl:attribute name="class">name</xsl:attribute>

          <xsl:choose>
            <xsl:when test="./name/@href">
              <xsl:element name="a">
                <xsl:attribute name="href"><xsl:value-of select="./name/@href"/></xsl:attribute>
                <xsl:value-of select="./name"/>
              </xsl:element>
            </xsl:when>

            <xsl:otherwise>
              <xsl:value-of select="./name"/>
            </xsl:otherwise>
          </xsl:choose>

        </xsl:element>
      </xsl:if>

      <xsl:for-each select="./desc">
        <xsl:call-template name="desc">
        </xsl:call-template>
      </xsl:for-each>

    </xsl:element>
  </xsl:template>

  <xsl:template name="navbar" >
     <xsl:param name="num" select="'0'"/>
     <xsl:param name="total" select="'0'"/>

     <xsl:variable name="previous">slide<xsl:value-of select="$num - 1"/>.html</xsl:variable>
     <xsl:variable name="previousTitle">Slide <xsl:value-of select="$num - 1"/></xsl:variable>
     <xsl:variable name="next">slide<xsl:value-of select="$num + 1"/>.html</xsl:variable>
     <xsl:variable name="nextTitle">Slide <xsl:value-of select="$num + 1"/></xsl:variable>

     <xsl:variable name="last">slide<xsl:value-of select="$total"/>.html</xsl:variable>
     <xsl:variable name="lastTitle">Slide <xsl:value-of select="$total"/></xsl:variable>

        <xsl:element name="nav">
          <xsl:attribute name="id">nav</xsl:attribute>
          <xsl:attribute name="class">navbar navbar-default navbar-fixed-top</xsl:attribute>

          <xsl:element name="div">
            <xsl:attribute name="class">container</xsl:attribute>

              <xsl:element name="div">
               <xsl:attribute name="class">navbar-header</xsl:attribute>
               <xsl:element name="button">
                 <xsl:attribute name="class">navbar-toggle collapsed navbar-left</xsl:attribute>
                 <xsl:attribute name="data-toggle">collapse</xsl:attribute>
                 <xsl:attribute name="data-target">#slide-nav</xsl:attribute>
                 <xsl:element name="span">
                  <xsl:attribute name="class">sr-only</xsl:attribute>
                  Toggle navigation
                </xsl:element>
                <xsl:element name="span"><xsl:attribute name="class">icon-bar</xsl:attribute></xsl:element>
                <xsl:element name="span"><xsl:attribute name="class">icon-bar</xsl:attribute></xsl:element>
                <xsl:element name="span"><xsl:attribute name="class">icon-bar</xsl:attribute></xsl:element>
              </xsl:element>
            </xsl:element>

            <xsl:element name="div">
              <xsl:attribute name="id">slide-nav</xsl:attribute>
              <xsl:attribute name="class">collapse navbar-collapse</xsl:attribute>

              <xsl:element name="ul">
                <xsl:attribute name="class">nav navbar-nav</xsl:attribute>

                <xsl:choose>
                  <xsl:when test="$num=0">
                    <xsl:element name="li">
                      <xsl:attribute name="class">disabled</xsl:attribute>
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_INDEX</xsl:attribute>
                        <xsl:attribute name="href">#</xsl:attribute>
                        Index
                      </xsl:element>
                    </xsl:element>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:element name="li">
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_INDEX</xsl:attribute>
                        <xsl:attribute name="href">index.html</xsl:attribute>
                        Index
                      </xsl:element>
                    </xsl:element>
                  </xsl:otherwise>
                </xsl:choose>

                <xsl:choose>
                  <xsl:when test="$num>1">
                    <xsl:element name="li">
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_FIRST</xsl:attribute>
                        <xsl:attribute name="href">slide1.html</xsl:attribute>
                        <xsl:attribute name="title">Slide 1</xsl:attribute>
                        First
                      </xsl:element>
                    </xsl:element>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:element name="li">
                      <xsl:attribute name="class">disabled</xsl:attribute>
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_FIRST</xsl:attribute>
                        <xsl:attribute name="href">slide1.html</xsl:attribute>
                        <xsl:attribute name="title">On First Slide</xsl:attribute>
                        First
                      </xsl:element>
                    </xsl:element>
                  </xsl:otherwise>
                </xsl:choose>

                <xsl:choose>
                  <xsl:when test="$num>1">
                    <xsl:element name="li">
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_PREVIOUS</xsl:attribute>
                        <xsl:attribute name="href"><xsl:value-of select="$previous"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="$previousTitle"/></xsl:attribute>
                        Previous
                      </xsl:element>
                    </xsl:element>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:element name="li">
                      <xsl:attribute name="class">disabled</xsl:attribute>
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_PREVIOUS</xsl:attribute>
                        <xsl:attribute name="href">#</xsl:attribute>
                        <xsl:attribute name="title">On First Slide</xsl:attribute>
                        Previous
                      </xsl:element>
                    </xsl:element>
                  </xsl:otherwise>
                </xsl:choose>

                <xsl:choose>
                  <xsl:when test="$num=0">
                    <xsl:element name="li">
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_NEXT</xsl:attribute>
                        <xsl:attribute name="href"><xsl:value-of select="$next"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="$nextTitle"/></xsl:attribute>
                        Next
                      </xsl:element>
                    </xsl:element>
                    <xsl:element name="li">
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_LAST</xsl:attribute>
                        <xsl:attribute name="href"><xsl:value-of select="$last"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="$lastTitle"/></xsl:attribute>
                        Last
                      </xsl:element>
                    </xsl:element>
                  </xsl:when>

                  <xsl:when test="$num&lt;$total">
                    <xsl:element name="li">
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_NEXT</xsl:attribute>
                        <xsl:attribute name="href"><xsl:value-of select="$next"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="$nextTitle"/></xsl:attribute>
                        Next
                      </xsl:element>
                    </xsl:element>
                    <xsl:element name="li">
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_LAST</xsl:attribute>
                        <xsl:attribute name="href"><xsl:value-of select="$last"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="$lastTitle"/></xsl:attribute>
                        Last
                      </xsl:element>
                    </xsl:element>
                  </xsl:when>

                  <xsl:otherwise>
                    <xsl:element name="li">
                      <xsl:attribute name="class">disabled</xsl:attribute>
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_NEXT</xsl:attribute>
                        <xsl:attribute name="href">#</xsl:attribute>
                        <xsl:attribute name="title">On Last Slide</xsl:attribute>
                        Next
                      </xsl:element>
                    </xsl:element>
                    <xsl:element name="li">
                      <xsl:attribute name="class">disabled</xsl:attribute>
                      <xsl:element name="a">
                        <xsl:attribute name="id">ID_SLIDE_LAST</xsl:attribute>
                        <xsl:attribute name="href">#</xsl:attribute>
                        <xsl:attribute name="name">On Last Slide</xsl:attribute>
                        Last
                      </xsl:element>
                    </xsl:element>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:element>

              <xsl:element name="ul">
                <xsl:attribute name="class">nav navbar-nav pull-right</xsl:attribute>
                <xsl:if test="/slides/addtranscript">
                  <xsl:element name="li">
                    <xsl:attribute name="style">float: left</xsl:attribute>
                    <xsl:element name="a">
                      <xsl:attribute name="target">transcript</xsl:attribute>
                      <xsl:attribute name="href">transcript.html#slide<xsl:value-of select="$num"/></xsl:attribute>
                        Full Audio Transcript
                    </xsl:element>
                  </xsl:element>
                </xsl:if>

                <xsl:if test="not(/slides/noslidenumbers)">
                  <xsl:if test="position() > 0">
                    <xsl:element name="li">
                      <xsl:attribute name="class">nav navbar-text</xsl:attribute>
                        <xsl:text>Slide </xsl:text>
                        <xsl:value-of select="position()"/>
                        <xsl:text> of </xsl:text>
                        <xsl:value-of select="last()"/>
                    </xsl:element>
                  </xsl:if>
                </xsl:if>

              </xsl:element>
            </xsl:element>
          </xsl:element>
       </xsl:element>
  </xsl:template>
</xsl:stylesheet>






