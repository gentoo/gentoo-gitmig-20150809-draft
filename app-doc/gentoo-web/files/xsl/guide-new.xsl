<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/> 

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
		<a href="#{generate-id()}"><xsl:value-of select="title"/></a>
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
		<a href="mailto:{@email}"><xsl:value-of select="."/></a>
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
	<a name="{generate-id()}"><p class="chaphead"><xsl:value-of select="title"/></p></a>
	<xsl:apply-templates select="section"/>
</xsl:template>

<xsl:template match="section">
	<p class="secthead"><xsl:value-of select="title"/></p>
	<xsl:apply-templates select="body"/>
</xsl:template>

<xsl:template match="note">
	<p class="note"><b>Note:</b>
	<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="codenote">
	<br/><span class="codenote">(<b>Note:</b> <xsl:value-of select="." />)</span>
</xsl:template>


<xsl:template match="important">
	<p class="importanthead"><xsl:value-of select="title"/></p>
	<xsl:apply-templates select="body"/>
</xsl:template>

<xsl:template match="warning">
	<p class="warninghead"><xsl:value-of select="title"/></p>
	<xsl:apply-templates select="body"/>
</xsl:template>

<xsl:template match="body">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="code">
	<span class="code"><xsl:apply-templates /></span> 
</xsl:template>

<xsl:template match="pre">
	<pre>
	<xsl:apply-templates />
	</pre>
</xsl:template>

<xsl:template match="path">
	<span class="path"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="p">
	<p class="para"><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="e">
	<span class="emphasis"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="link">
	<a href="{@path}"><xsl:value-of select="."/></a>
</xsl:template>

<xsl:template match="mail">
	<a href="mailto:{@link}"><xsl:value-of select="."/></a>
</xsl:template>

<xsl:template match="table">
	<table><xsl:apply-templates /></table>
</xsl:template>

<xsl:template match="tr">
	<tr><xsl:apply-templates /></tr>
</xsl:template>

<xsl:template match="ti">
	<td class="tableinfo"><xsl:apply-templates /></td>
</xsl:template>

<xsl:template match="th">
	<td class="tablehead"><b><xsl:apply-templates /></b></td>
</xsl:template>

</xsl:stylesheet>

