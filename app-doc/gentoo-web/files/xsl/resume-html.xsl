<?xml version='1.0' encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="iso-8859-1" method="html" indent="yes"/> 

<xsl:template match="/resume">
<html>
<head>
    <link title="new" rel="stylesheet" href="resume.css" type="text/css"></link>
	<title>Daniel Robbins</title>
</head>
<body bgcolor="#ffffff">
<br/>
<center>
<p class="address">
<b><span class="secthead"><xsl:value-of select="name"/></span><br/><br/>
<xsl:apply-templates select="contactinfo"/>
</b></p>
</center>
<p class="secthead"><b>Experience</b></p>
<xsl:apply-templates select="employer"/>
<p class="secthead"><b>Skills</b></p>
<xsl:apply-templates select="skills"/>
<p class="secthead"><b>Education</b></p>
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
	<table class="desc" border="0" width="100%">
		<xsl:apply-templates select="school"/>
	</table>
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
	<p class="employer"><b><xsl:apply-templates select="name"/></b>
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
	<p class="desc"><xsl:apply-templates /></p>
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

