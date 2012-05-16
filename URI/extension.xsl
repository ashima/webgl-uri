<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="*|node()">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates select="node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="template[@name='uri_to_khronos']">
    <xsl:apply-templates select="document(@src)" mode="uri_to_khronos"/>
  </xsl:template>

  <xsl:template match="extension|draft" mode="uri_to_khronos">
    <tr>
      <td><xsl:value-of select="concat(@xml:base,@href)" /></td>
      <td><xsl:value-of select="@name" /></td>
    </tr>
  </xsl:template>

  <xsl:template match="registry" mode="uri_to_khronos">
    <table id="uri_to_khronos">
      <tr><th>URI</th><th>Khronos WebGL Extension</th></tr>
      <xsl:copy>
        <xsl:apply-templates select="extension|draft" mode="uri_to_khronos">
          <xsl:sort select="number" data-type="number" order="ascending" />
        </xsl:apply-templates>
      </xsl:copy>
    </table>
  </xsl:template>
</xsl:stylesheet>

