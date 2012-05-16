<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output omit-xml-declaration="yes" />
  
  <xsl:param name="date" />
  <xsl:param name="diff" />

  <xsl:template match="*|node()" name="copy-template">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates select="node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="revision">
    <xsl:copy>
      <xsl:attribute name="date"><xsl:value-of select="$date" /></xsl:attribute>
      <xsl:apply-templates select="node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template name="output-changes-from-diff">
    <xsl:param name="diff" />
    <xsl:variable name="top" select="substring-before($diff,'&#xA;')" />
    <xsl:variable name="rest" select="substring-after($diff,'&#xA;')" />

    <change><xsl:value-of select="$top" /></change>

    <xsl:if test="$rest">
      <xsl:call-template name="output-changes-from-diff">
        <xsl:with-param name="diff" select="$rest" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template match="diff">
    <xsl:call-template name="output-changes-from-diff">
      <xsl:with-param name="diff" select="concat($diff,'&#xA;')" />
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>

