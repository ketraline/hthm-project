<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template match="/">
<html>
<head>
<style>
body { font-family: monospace; background:#f4f4f4; }
li { margin:8px; }
</style>
</head>
<body>

<h2>Game Names and Scores</h2>

<ul>
<xsl:for-each select="catalog/game">
    <li>
        <xsl:value-of select="name"/>
        —
        <xsl:value-of select="statistics/score"/>
    </li>
</xsl:for-each>
</ul>

</body>
</html>
</xsl:template>

</xsl:stylesheet>
