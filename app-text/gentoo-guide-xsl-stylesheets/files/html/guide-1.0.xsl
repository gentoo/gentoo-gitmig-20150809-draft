<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/> 

<xsl:template match="/guide">
	<html>
	<head>
	<title><xsl:value-of select="title"/></title>
	<link rel="stylesheet" href="gentoo-doc.css" type="text/css"/>
	</head>
	<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
	<table class="toptable" width="100%" cellspacing="0" cellpadding="0" border="0" bgcolor="#000000">
	<tr><td width="160" height="129" align="left" valign="top"><a href="/"><img border="0" src="gentoo-doc.gif"/></a></td>
	<td>&amp;nbsp;</td></tr>
	<tr>
		<td colspan="2" class="doclink">
			<a href="/doc" style="color: #33ff00">documentation</a> :: <xsl:value-of select="title"/>
		</td>
	</tr>
</table>
	<table class="secondtable" width="95%" cellspacing="0" cellpadding="2" border="0">
	<tr><td valign="top">
	<p class="dochead"><xsl:value-of select="title"/></p>
	</td><td valign="top">
	<p class="info">
	<xsl:apply-templates select="author"/>
	Version <xsl:value-of select="version"/>, <xsl:value-of select="date"/></p>
	</td></tr>		
	<tr><td>
	<p class="tochead">Summary</p>
	<p class="abstract">
	<xsl:value-of select="abstract"/>
	</p>
	</td><td width="25%" valign="top">
	<p class="tochead">Table of contents:</p>
	<p class="tocitem">
	<xsl:for-each select="chapter">
		&lt;a href="#<xsl:value-of select="./@link"/>"&gt;
		<xsl:value-of select="title"/>&lt;/a&gt;
		<br/>
	</xsl:for-each>		
	</p>
	</td>
	</tr>
</table>
	<xsl:apply-templates select="chapter"/>
	</body>
	</html>
</xsl:template>

<xsl:template match="author">
<xsl:choose>
	<xsl:when test="@email">
		<![CDATA[<a href="mailto:]]><xsl:value-of select="@email"/><![CDATA[">]]>
		<xsl:value-of select="."/><![CDATA[</a>]]>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="."/>
	</xsl:otherwise>
</xsl:choose>
<xsl:if test="@title">, <i><xsl:value-of select="@title"/></i>
</xsl:if>	
<br/>
</xsl:template>

<xsl:template match="chapter">
	&lt;a name="<xsl:value-of select="./@link"/>"&gt;
	<p class="chaphead"><xsl:value-of select="title"/></p>&lt;/a&gt;
	<xsl:apply-templates select="section"/>
</xsl:template>

<xsl:template match="section">
	<p class="secthead"><xsl:value-of select="title"/></p>
	<xsl:apply-templates select="body"/>
</xsl:template>

<xsl:template match="body">
	<xsl:copy-of select="./node()"/>
</xsl:template>

</xsl:stylesheet>
