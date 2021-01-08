<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">

<xsl:template match="/">
<xsl:apply-templates />
</xsl:template>

<!-- template for each slide -->
<xsl:template match="/p:sld">
<xsl:text>

---

</xsl:text>
            <xsl:apply-templates select="*//a:t"/>
            <xsl:apply-templates select="*//p:cNvPr[contains(@name,'Picture')]"/>   
</xsl:template>


<!-- template for texte -->
<xsl:template match="*//a:t">
<xsl:text>
- </xsl:text>
<xsl:value-of select="."/>
</xsl:template>
  
<!-- template for pictures -->
<xsl:template match="*//p:cNvPr[contains(@name,'Picture')]">
<xsl:text>

![</xsl:text>
<xsl:value-of select="@name"/>
<xsl:text>](</xsl:text>
<xsl:value-of select="@descr"/>
<xsl:text>)</xsl:text>
<xsl:text>

&gt;img width='100' height='100' data-src='</xsl:text>
<xsl:value-of select="@descr"/>
<xsl:text>'&lt;</xsl:text>
<xsl:value-of select="@name"/>
<xsl:text>&gt;/img&lt;

</xsl:text>
</xsl:template>
</xsl:stylesheet>

