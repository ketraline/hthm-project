<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
<library>
    <xsl:apply-templates select="catalog/game"/>
</library>
</xsl:template>

<xsl:template match="game">

    <xsl:element name="{name}">
        
        <xsl:attribute name="{statistics/developer}">
            <xsl:value-of select="@id"/>
        </xsl:attribute>

        <information>
            <releaseDate>
                <year>
                    <xsl:value-of select="statistics/date"/>
                </year>
            </releaseDate>

            <rating>
                <xsl:copy-of select="statistics/score"/>
            </rating>
        </information>

        <xsl:copy>
            <xsl:apply-templates select="tags/node()"/>
        </xsl:copy>

    </xsl:element>

</xsl:template>

</xsl:stylesheet>
