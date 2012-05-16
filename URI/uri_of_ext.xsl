<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template name="uri_of_ext">
    <xsl:choose>
      <xsl:when test="contains(@href,':')">
        <xsl:value-of select="@href" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(../@xml:base,@href)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>