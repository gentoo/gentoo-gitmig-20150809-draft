<?xml version='1.0' encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="iso-8859-1" method="html" indent="yes"/> 

<xsl:template match="mainpage">
<html>
<head>
    <link title="new" rel="stylesheet" href="/resume.css" type="text/css"></link>
	<title>Daniel Robbins</title>
</head>
<body bgcolor="#ffffff">
	<xsl:apply-templates select="chapter"/>
</body>
</html>
</xsl:template>

<xsl:template match="newspage">
<html>
<head>
    <link title="new" rel="stylesheet" href="/resume.css" type="text/css"></link>
	<title>Daniel Robbins</title>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" bgcolor="#ffffff">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td valign="top" align="left">
	<center>
	<img src="images/newg.png"/>
	<br/>
	<p class="secthead"><b>gentoo.org: </b><a href="">foo</a> | <a href="">foo</a> | <a href="">foo</a></p>
	</center>
	<br/>
	<xsl:apply-templates select="newsitems"/>
	</td><!--
	<td valign="top" bgcolor="#d2d9a3" width="150">-->
	<td valign="top" align="left" width="150">
		<br/>
		<img src="/images/icon-linux.png"/>
		<br/>
		<br/>
		<p class="nopad">
			Download Mirrors:<br/>
			<a href="http://www.ibiblio.org/gentoo">ibiblio.org (USA)</a><br/>
			<a href="http://cfx5.tgv.net/">tgv.net (France, high speed)</a><br/>
			<a href="ftp://ftp.ilug-bom.org.in/Linux/distributions/gentoo/">ILUG Bombay (India)</a><br/><br/>
		</p>
		<p class="nopad">
			User Docs:<br/>
			<font color="#ff0000">Updated</font> <a href="/doc/faq.html">FAQ</a><br/>
			<a  href="/doc/desktop.html">Desktop Guide</a><br/>
			<a  href="/doc/portage-user.html">Portage User Guide</a><br/>
			<font color="#ff0000">New!</font> <a  href="/doc/openafs.html">OpenAFS Installation Guide</a><br/>
			<font color="#ff0000">New for 1.0_rc6!</font><a  href="/doc/build.html">"From Source" CD Install Guide</a><br/>
			<a  href="/doc/nvidia_tsg.html">nvidia Troubleshooting Guide</a>
		</p>
		<p class="nopad">
			<a href="http://www.qksrv.net/click-477620-57886" target="_top" >
			<img src="http://www.qksrv.net/image-477620-57886" width="88" height="31" alt="Online Auto Loans" border="0"/></a>	
		</p>
		<p class="nopad">
			Developer Docs:<br/>
			<font color="#ff0000">New!</font> <a  href="/doc/cvs-tutorial.html">CVS Tutorial</a><br/>
			<font color="#ff0000">Updated 21 Sep 2001:</font> <a  href="/doc/gentoo-howto.html">Development HOWTO</a><br/>
			<a  href="/doc/xml-guide.html">XML Documentation Guide</a><br/>
		</p>
		<p class="nopad">
			Mailing Lists:<br/>
			<font color="#ff0000">New!</font> <a  href="http://cvs.gentoo.org/mailman/listinfo/gentoo-ebuild">gentoo-ebuild</a><br/>
			<a  href="http://cvs.gentoo.org/mailman/listinfo/gentoo-dev">gentoo-dev</a><br/>
			<a  href="http://cvs.gentoo.org/mailman/listinfo/gentoo-announce">gentoo-announce</a><br/>
			<a  href="http://cvs.gentoo.org/mailman/listinfo/gentoo-cvs">gentoo-cvs</a><br/>
			<a  href="http://cvs.gentoo.org/mailman/listinfo">complete list</a><br/>
		</p>
		<p class="nopad">
			Other Resources:<br/>
			<a  href="http://cvs.gentoo.org/cgi-bin/cvsweb.cgi">cvsweb</a> (browse our repository)<br/>
			IRC: #gentoo on <a  href="http://www.openprojects.net/">OPN</a><br/>
		</p>
	</td>
	</tr>
	</table>
</body>
</html>
</xsl:template>

<xsl:template match="newsitems">
	<xsl:apply-templates select="news"/>
</xsl:template>

<xsl:template match="news">
	<p class="secthead"><b><xsl:value-of select="title"/></b></p>
	<p>Posted by <xsl:value-of select="poster"/> on <xsl:value-of select="date"/></p>
	<xsl:apply-templates select="body"/>
	<br/>
</xsl:template>


<xsl:template match="chapter">
	<xsl:variable name="chapid">doc_chap<xsl:number/></xsl:variable>
	<xsl:choose>
	<xsl:when test="title">
		<p class="chaphead"><b><a name="{$chapid}"><xsl:number/>.</a> <xsl:value-of select="title"/></b></p>
	</xsl:when>
	<xsl:otherwise>
		<xsl:if test="/guide">
			<p class="chaphead"><b><a name="{$chapid}"><xsl:number/>.</a></b></p> 
		</xsl:if>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates select="section"/>
</xsl:template>

<xsl:template match="section">
	<xsl:if test="title">
		<xsl:variable name="sectid"><xsl:value-of select="$chapid"/>_sect<xsl:number/></xsl:variable>
		<p class="secthead"><a name="{$sectid}"><xsl:value-of select="title"/>&#160;</a></p>
	</xsl:if>
	<xsl:apply-templates select="body"/>
</xsl:template>

<xsl:template match="/resume">
<html>
<head>
    <link title="new" rel="stylesheet" href="/resume.css" type="text/css"></link>
	<title>Daniel Robbins</title>
</head>
<body bgcolor="#ffffff">
<br/>
<center>
<p class="address">
<b><span class="chaphead"><xsl:value-of select="name"/></span><br/><br/>
<xsl:apply-templates select="contactinfo"/>
</b></p>
</center>
<p class="chaphead"><b>Experience</b></p>
<xsl:apply-templates select="employer"/>
<p class="chaphead"><b>Skills</b></p>
<xsl:apply-templates select="skills"/>
<p class="chaphead"><b>Education</b></p>
<xsl:apply-templates select="education"/>
<br/>
<br/>
<br/>
</body>
</html>
</xsl:template>

<xsl:template match="contactinfo">
<xsl:apply-templates />
</xsl:template>

<xsl:template match="line">
<xsl:apply-templates /><br/>
</xsl:template>

<xsl:template match="education">
	<p>
	<table border="0" width="100%">
		<xsl:apply-templates select="school"/>
	</table>
	</p>
</xsl:template>

<xsl:template match="school">
	 	<tr>
			<td>
				<b><xsl:apply-templates select="name"/></b>, <xsl:value-of select="location"/>
			</td>
			<td>
				<xsl:value-of select="start"/> to <xsl:value-of select="stop"/>
			</td>
		</tr>
</xsl:template>

<xsl:template match="skills">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="employer">
	<p class="secthead"><b><xsl:apply-templates select="name"/></b>
	</p>
	<xsl:apply-templates select="position"/>
</xsl:template>

<xsl:template match="position">
	<p class="header">
	<b><xsl:apply-templates select="title"/></b><br/>
	<xsl:value-of select="start"/> to <xsl:value-of select="stop"/>
	</p>
	<xsl:apply-templates select="body"/>
</xsl:template>

<xsl:template match="body/p">
	<p><xsl:apply-templates /></p>
</xsl:template>


<xsl:template match="ul">
	<ul class="list"><xsl:apply-templates /></ul>
</xsl:template>

<xsl:template match="li/ul">
	<ul class="sublist"><xsl:apply-templates /></ul>
</xsl:template>

<xsl:template match="p">
	<p><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="ol">
	<ol class="list"><xsl:apply-templates /></ol>
</xsl:template>

<xsl:template match="li/ol">
	<ol class="sublist"><xsl:apply-templates /></ol>
</xsl:template>

<xsl:template match="li">
	<li class="listitem"><xsl:apply-templates /></li>
</xsl:template>

<xsl:template match="body/ul/li">
	<li><xsl:apply-templates /></li>
</xsl:template>

<xsl:template match="body/ol/li">
	<li><xsl:apply-templates /></li>
</xsl:template>


<xsl:template match="li/ol/li">
	<li class="sublistitem"><xsl:apply-templates /></li>
</xsl:template>

<xsl:template match="li/ul/li">
	<li class="sublistitem"><xsl:apply-templates /></li>
</xsl:template>


<xsl:template match="br"><br/></xsl:template>

<xsl:template match="i">
	<font class="input"><xsl:apply-templates /></font>
</xsl:template>

<xsl:template match="b">
	<b><xsl:apply-templates /></b>
</xsl:template>

<xsl:template match="brite">
	<font color="#ff0000"><b><xsl:apply-templates /></b></font>
</xsl:template>

<xsl:template match="body">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="path">
	<font class="path"><xsl:value-of select="."/></font>
</xsl:template>

<xsl:template match="uri">
	<!-- expand templates to handle things like <uri link="http://bar"><c>foo</c></uri> -->
	<xsl:choose>
		<xsl:when test="@link">
			<a href="{@link}"><xsl:apply-templates /></a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="loc" select="."/>
			<a href="{$loc}"><xsl:apply-templates /></a>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="e">
	<i><xsl:apply-templates /></i>
</xsl:template>

<xsl:template match="mail">
	<a href="mailto:{@link}"><xsl:value-of select="."/></a>
</xsl:template>

<xsl:template match="table">
	<table class="ntable"><xsl:apply-templates /></table>
</xsl:template>

<xsl:template match="tr">
	<tr><xsl:apply-templates /></tr>
</xsl:template>

<xsl:template match="ti">
	<td bgcolor="#ddddff" class="tableinfo"><xsl:apply-templates /></td>
</xsl:template>

<xsl:template match="th">
	<td bgcolor="#7a5ada" class="infohead"><b><xsl:apply-templates /></b></td>
</xsl:template>
</xsl:stylesheet>

