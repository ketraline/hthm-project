<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:variable name="gameCount" select="count(/catalog/game)"/>
<xsl:variable name="avgScore"
    select="sum(/catalog/game/statistics/score) div $gameCount"/>
<xsl:variable name="hasGames" select="$gameCount &gt; 0"/>

<xsl:template match="/">
<html>
<head>
    <title>Favorite Game Catalog</title>
    <style>
        body { font-family: Arial; background:#111; color:#eee; }
        .game { border:1px solid #646464ff; margin:20px; padding:15px;background-color:#292929ff }
        h2 { color:#9cf; }
        .score { font-weight:bold; }
        img { max-width:120px; }
        a { color:#9cf; }
        li {list-style-type:none}
    </style>
</head>
<body>

<h1>Favorite Game Catalog</h1>
<p>Total games: <xsl:value-of select="$gameCount"/></p>
<p>Average score: <xsl:value-of select="format-number($avgScore,'##.00')"/></p>


<xsl:if test="$hasGames">
    <xsl:apply-templates select="catalog/game"/>
</xsl:if>

</body>
</html>
</xsl:template>

<xsl:template match="game">
<div class="game">

    <h2>
        <xsl:number level="any" format="1. "/>
        <xsl:value-of select="name"/>
    </h2>

    <xsl:apply-templates select="image"/>
    <xsl:apply-templates select="quote"/>
    <xsl:apply-templates select="statistics"/>
    <xsl:apply-templates select="characters/character"/>
    <xsl:apply-templates select="gallery/image[position() &lt;= 4]"/>

</div>
</xsl:template>

<xsl:template match="@source">
    <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="image">
    <img src="{@source}" alt="{text()}"/>
</xsl:template>

<xsl:template match="quote">
    <br/>
    <xsl:value-of select="normalize-space(text())"/>
    —
    <a href="{link/@source}">
        <xsl:value-of select="link"/>
    </a>
</xsl:template>

<xsl:template match="statistics">
<p>
    Developer:
    <xsl:value-of select="developer"/>
    <br/>

    Score:
    <span class="score">
        <xsl:value-of select="format-number(score, '##')"/>
    </span>

    <br/>
    DLC:
    <xsl:choose>
        <xsl:when test="dlc/@isPresent='Yes'">
            Available
        </xsl:when>
        <xsl:otherwise>
            None
        </xsl:otherwise>
    </xsl:choose>
</p>

<ul>
<xsl:for-each select="dlcList/title">
    <xsl:sort select="@date" data-type="number"/>
    <li>
        <xsl:number format="1. "/>
        <xsl:value-of select="."/>
        (<xsl:value-of select="@date"/>)
    </li>
</xsl:for-each>
</ul>

</xsl:template>

<xsl:template match="character">
    <p>
        <strong>
            <xsl:call-template name="uppercase">
                <xsl:with-param name="text" select="@name"/>
            </xsl:call-template>
        </strong>
        <br/>
        <xsl:apply-templates select="image"/>
    </p>
</xsl:template>

<xsl:template name="uppercase">
    <xsl:param name="text"/>
    <xsl:value-of select="translate($text,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
</xsl:template>

</xsl:stylesheet>
