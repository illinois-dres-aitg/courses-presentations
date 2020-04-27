<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:wai_report="http://www.w3.org/wai"
                version="1.0"
    xmlns:lxslt="http://xml.apache.org/xslt"
    xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
    extension-element-prefixes="redirect">

  <xsl:output method="text"/>

  <xsl:template match="/">

      <xsl:for-each select="/slides/slide" >
        === Slide <xsl:value-of select="position()"/> ===
        <xsl:choose>
          <xsl:when test="transcript">
            <xsl:value-of select="transcript/."/>
          </xsl:when>
          <xsl:otherwise>
              No transcript found for this slide.
          </xsl:otherwise>
        </xsl:choose>

      </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>






