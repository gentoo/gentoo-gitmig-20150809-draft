<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/> 
<xsl:preserve-space elements="pre"/>

<xsl:template match="/guide">
	<html>
	<head>
	<title><xsl:value-of select="title"/></title>
	<link rel="stylesheet" href="/doc/gentoo-doc.css" type="text/css"/>
	</head>
	<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
	<table class="toptable" width="100%" cellspacing="0" cellpadding="0" border="0" bgcolor="#000000">
	<tr><td width="160" height="129" align="left" valign="top"><a href="/"><img border="0" src="/projects/gentoo-project.jpg"/></a></td>
	<td>&amp;nbsp;</td></tr>
	<tr>
		<td colspan="2" class="doclink">
			<!-- <a href="/doc" style="color: #33ff00">documentation</a> :: <xsl:value-of select="title"/> -->
			projects :: <xsl:value-of select="title"/>
		</td>
	</tr>
</table>
	<table class="secondtable" width="95%" cellspacing="0" cellpadding="2" border="0">
	<tr><td valign="top">
	<p class="dochead"><xsl:value-of select="title"/></p>
	</td><td valign="top">
	<p class="info">
	<xsl:apply-templates select="author"/>
	Doc Revision <xsl:value-of select="version"/>, <xsl:value-of select="date"/></p>
	</td></tr>		
	<tr><td>
	<p class="tochead">Project Summary</p>
	<p class="abstract">
	<xsl:value-of select="abstract"/>
	</p>
	</td><td width="25%" valign="top">
	<p class="tochead">Table of contents:</p>
	<p class="tocitem">
	<xsl:for-each select="chapter">
		<xsl:variable name="chapid">doc_chap<xsl:number/></xsl:variable>
		<a href="#{$chapid}"><xsl:number/>. <xsl:value-of select="title"/></a>
		<br/>
	</xsl:for-each>		
	</p>
	</td>
	</tr>
</table>
	<xsl:apply-templates select="chapter"/>
	<br/>
	<br/>
	<table class="tochead" width="100%" border="0"><tr><td align="right">Copyright 2001 Gentoo Technologies, Inc.<br/>
	Questions, Comments, Corrections?  Email <a href="mailto:gentoo-dev@gentoo.org">gentoo-dev@gentoo.org</a>.</td></tr></table>
	</body>
	</html>
</xsl:template>

<xsl:template match="mail">
	<a href="mailto:{@link}"><xsl:value-of select="."/></a>
</xsl:template>

<xsl:template match="author">
	<xsl:apply-templates />
	<xsl:if test="@title">, <i><xsl:value-of select="@title"/></i>
	</xsl:if>	
	<br/>
</xsl:template>

<xsl:template match="chapter">
	<xsl:variable name="chapid">doc_chap<xsl:number/></xsl:variable>
	<a name="#{$chapid}"><p class="chaphead"><xsl:value-of select="title"/></p></a>
	<xsl:apply-templates select="section"/>
</xsl:template>

<xsl:template match="section">
	<xsl:variable name="sectid"><xsl:value-of select="$chapid"/>_sect<xsl:number/></xsl:variable>
	<a name="#{$sectid}"><p class="secthead"><xsl:value-of select="title"/></p></a>
	<xsl:apply-templates select="body"/>
</xsl:template>

<xsl:template match="figure">
	<table border="0"><tr><td>
	<xsl:variable name="fignum"><xsl:number level="any"/></xsl:variable>
	<xsl:variable name="figid">doc_fig<xsl:number/></xsl:variable>
	<a name="#{$figid}"/>
	<xsl:choose>
		<xsl:when test="@short">
			<img src="{@link}" alt="Fig. {$fignum}: {@short}"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="{@link}" alt="Fig. {$fignum}"/>
		</xsl:otherwise>
	</xsl:choose>
	</td></tr><tr><td class="tochead">
	<xsl:choose>
		<xsl:when test="@caption">
			Figure <xsl:value-of select="$fignum"/>: <xsl:value-of select="@caption" />
		</xsl:when>
		<xsl:otherwise>
			Figure <xsl:value-of select="$fignum"/>
		</xsl:otherwise>
	</xsl:choose>
	</td></tr></table>
</xsl:template>
	
<xsl:template match="note">
	<p class="note"><b>Note: </b>
	<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="impo">
	<p class="impo"><b>Important: </b>
	<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="warn">
	<p class="warn"><b>Warning: </b>
	<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="codenote">
	<span class="comment">// <xsl:value-of select="." /></span>
</xsl:template>

<xsl:template match="comment">
	<span class="comment"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="i">
	<span class="input"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="body">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="c">
	<span class="code"><xsl:apply-templates /></span> 
</xsl:template>

<xsl:template match="pre">
	<xsl:variable name="prenum"><xsl:number level="any" /></xsl:variable>
	<xsl:variable name="preid">doc_pre<xsl:number level="any" /></xsl:variable>
	<a name="#{$preid}"/>
	<p class="caption">
	<xsl:choose>
		<xsl:when test="@caption">
			Code listing <xsl:value-of select="$prenum"/>: <xsl:value-of select="@caption" />
		</xsl:when>
		<xsl:otherwise>
			Code listing <xsl:value-of select="$prenum"/>
		</xsl:otherwise>
	</xsl:choose>
	</p>
	<pre> 
		<xsl:apply-templates /> 
	</pre> 
	</xsl:template>

<!-- path is used for specifying files and URLs; if you are linking
part of a sentence rather than a path, then don't use this, use span instead-->
<xsl:template match="path">
	<span class="path"><xsl:value-of select="."/></span>
</xsl:template>

<xsl:template match="uri">
	<xsl:choose>
		<xsl:when test="@link">
			<a href="{@link}"><xsl:value-of select="."/></a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="loc" select="."/>
			<a href="{$loc}"><xsl:value-of select="."/></a>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="p">
	<p class="para"><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="e">
	<span class="emphasis"><xsl:apply-templates /></span>
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
	<td class="tochead"><b><xsl:apply-templates /></b></td>
</xsl:template>

<xsl:template match="ul">
	<ul><xsl:apply-templates /></ul>
</xsl:template>

<xsl:template match="ol">
	<ol><xsl:apply-templates /></ol>
</xsl:template>

<xsl:template match="li">
	<li><xsl:apply-templates /></li>
</xsl:template>

</xsl:stylesheet>

