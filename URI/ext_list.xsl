<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="uri_of_ext.xsl" />

  <xsl:output method="text" />

  <xsl:template match="extension|draft">
    <xsl:value-of select="name" /><xsl:text> </xsl:text>&lt;<xsl:call-template name="uri_of_ext" />&gt;<xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template match="/registry">
    <xsl:apply-templates select="extension|draft">
      <xsl:sort select="number" data-type="number" order="ascending" />
    </xsl:apply-templates>
  </xsl:template>
</xsl:stylesheet>

