<?xml version='1.0' encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="iso-8859-1" method="html" indent="yes"/> 
<xsl:preserve-space elements="pre"/>

<xsl:template match="/guide">
<html>
<head>
<title>Gentoo Linux</title>
    <link title="new" rel="stylesheet" href="main-new.css" type="text/css"></link>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" bgcolor="#ffffff">
	<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td height="168" width="30%" bgcolor="#45347b">
				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr><td class="logobg" valign="bottom" align="center" height="120"><img src="gtop-new.jpg"/></td></tr>
					<tr><td class="logobg" valign="bottom" align="center" height="48"><img src="gbot-new.gif"/></td></tr>
				</table>
			</td>
			<td class="menu" valign="bottom" height="168" width="70%" bgcolor="#000000">
				<!--Netscape 4.7 table hack-->
				main menu ::<br/>
				&#160;&#160;<a class="oldlink" href="index.html">About Gentoo Linux</a><br/>
				&#160;&#160;<a class="oldlink" href="index-download.html">Download/Install</a><br/> <br/>
				docs ::<br/>
				&#160;&#160;<a class="highlight" href="fixme"><xsl:value-of select="title"/></a>
			</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" height="96" align="right" width="30%" bgcolor="#ffffff">
		
<!--content begin-->

<!--Netscape 4.7 hack table start-->
<table border="0" cellspacing="5" cellpadding="0" height="100%" width="100%">
<tr><td class="content" valign="top" align="left">
	<table class="infotab" align="right" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="infohead" align="center" bgcolor="#7a5ada">About this Document</td>
		</tr>
		<tr valign="top" bgcolor="#ddddff">
			<td class="infotext">
				<br/>
				<p class="infosub">Authors:</p>
				<p class="infolist">
				<xsl:apply-templates select="author"/>
				</p>
				<br/>
				<p class="infosub">Table of Contents:</p>
				<ol>
				<xsl:for-each select="chapter">
				<xsl:variable name="chapid">doc_chap<xsl:number/></xsl:variable>
				<li><a href="#{$chapid}"><xsl:value-of select="title"/></a></li>
				</xsl:for-each>		
				</ol>
				<br/>
				<p class="infosub">Doc Revision <xsl:value-of select="version"/>, <xsl:value-of select="date"/></p>
                </td>
		</tr>
	</table>
<p class="dochead"><xsl:value-of select="title"/></p>
<xsl:apply-templates select="chapter"/> 
<!--content end-->
</td></tr></table>
<!--Netscape 4.7 hack end-->
			</td>
		</tr>
		<tr>
			<td align="right" class="infohead" width="100%" colspan="2" bgcolor="#7a5ada">
			Copyright 2001 Gentoo
		Technologies, Inc.  Questions, Comments, Corrections?  Email <a class="highlight"
		href="mailto:gentoo-dev@gentoo.org">gentoo-dev@gentoo.org</a>.
			</td>
		</tr>
	</table>
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
	<a name="#{$chapid}"><p class="chaphead"><span class="chapnum"><xsl:number/>.</span> <xsl:value-of select="title"/></p></a>
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
	<table class="ncontent" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td bgcolor="#bbffbb">
	<p class="note"><b>Note: </b>
	<xsl:apply-templates />
	</p>
	</td></tr></table>
</xsl:template>

<xsl:template match="impo">
	<table class="ncontent" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td bgcolor="#ffffbb">
	<p class="impo"><b>Important: </b>
	<xsl:apply-templates />
	</p>
	</td></tr></table>
</xsl:template>

<xsl:template match="warn">
	<table class="ncontent" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td bgcolor="#ffbbbb">
	<p class="warn"><b>Warning: </b>
	<xsl:apply-templates />
	</p>
	</td></tr></table>
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
	<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr><td class="infohead" bgcolor="#7a5ada">
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
	</td></tr>
	<tr><td bgcolor="#ddddff">
	<pre> 
		<xsl:apply-templates /> 
	</pre> 
	</td></tr></table> 
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
	<p><xsl:apply-templates /></p>
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

