<?xml version='1.0' encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="iso-8859-1" method="html" indent="yes"/> 
<xsl:preserve-space elements="pre"/>

<xsl:template match="/guide">
<html>
<head>
<title>developerWorks : Linux : <xsl:value-of select="title"/></title>
<script type="text/javascript" language="JavaScript" src="style.js"></script>
</head>
<body>
<table>
<tr>
<td><span class="atitle"><xsl:value-of select="title"/></span></td></tr>
<tr>
<td><span class="atitle2"><xsl:value-of select="subtitle"/></span></td></tr>
</table>

<!-- Start TOC (optional) -->

<table width="150" border="0" cellspacing="0" cellpadding="0">
<xsl:for-each select="chapter">
<xsl:variable name="chapid"><xsl:number/></xsl:variable>
<tr><td><a href="#{$chapid}"><xsl:value-of select="title"/></a></td></tr>
</xsl:for-each>
</table>

<!--  AUTHOR -->

<p><a href="#author1">Daniel Robbins</a> (<a href="drobbins@gentoo.org">drobbins@gentoo.org</a>)<br />
President/CEO, Gentoo Technologies, Inc.<br />
<xsl:value-of select="date"/></p>

<!--  End AUTHOR -->

<!-- ABSTRACT -->

<p><blockquote>
<xsl:apply-templates select="abstract"/>
</blockquote></p>

<!-- END ABSTRACT -->

<xsl:apply-templates select="chapter"/>

<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr><td>
<a name="author1"><span class="atitle2">About the author</span></a>
<p><img src="[author.jpg]" border="0" width="64" height="71" align="left" alt="author"/>
Residing in Albuquerque, New Mexico, Daniel Robbins (<a HREF="mailto:drobbins@gentoo.org">drobbins@gentoo.org</a>) is the
President/CEO of Gentoo Technologies,
Inc., the creator of <a href="http://www.gentoo.org">Gentoo Linux</a>, an advanced Linux for the
PC, and the <b>Portage</b> system, a next-generation ports system for Linux.
He has also served as a contributing author for the Macmillan books
<i>Caldera OpenLinux Unleashed</i>, <i>SuSE Linux Unleased</i> and <i>Samba Unleashed</i>.
Daniel has been involved with computers in some fashion since the
second grade, when he was first exposed to the Logo programming
language as well as a potentially dangerous dose of Pac Man.  This
probably explains why he has since served as a Lead Graphic Artist at
<b>SONY Electronic Publishing/Psygnosis</b>.  Daniel enjoys spending
time with his wife, Mary, and his new baby daughter, Hadassah.</p>
</td></tr>
</table>

<!-- END PAPER BODY -->


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
	<xsl:variable name="chapid"><xsl:number/></xsl:variable>
	<p><a name="{$chapid}"></a><span class="atitle2"><xsl:value-of select="title"/></span>
	</p>
	<xsl:apply-templates select="section"/>
</xsl:template>

<xsl:template match="section">
	<xsl:if test="title">
		<p><span class="atitle3"><xsl:value-of select="title"/></span></p>
	</xsl:if>
	<xsl:apply-templates select="body"/>
</xsl:template>

<xsl:template match="figure">
	<xsl:variable name="fignum"><xsl:number level="any"/></xsl:variable>
	<xsl:variable name="figid">figure<xsl:number/></xsl:variable>
	<p><a name="{$figid}"></a><b><xsl:value-of select="@caption" /></b>
	<br /><img src="{@link}" alt="{@short}"/></p>
</xsl:template>
	
<xsl:template match="note">
	<!-- SIDEBAR (OPTIONAL) -->
	<table border="1" cellpadding="5" cellspacing="0" width="30%" align="right"><tr><td background="/developerworks/i/bg-gold.gif">
	<p><b>Note: </b>
	<xsl:apply-templates />
	<!-- END OF SIDEBAR -->
	</p>
	</td></tr></table>
</xsl:template>

<xsl:template match="impo">
	<!-- SIDEBAR (OPTIONAL) -->
	<table border="1" cellpadding="5" cellspacing="0" width="30%" align="right"><tr><td background="/developerworks/i/bg-gold.gif">
	<p><b>Important: </b>
	<xsl:apply-templates />
	<!-- END OF SIDEBAR -->
	</p>
	</td></tr></table>
</xsl:template>

<xsl:template match="warn">
	<!-- SIDEBAR (OPTIONAL) -->
	<table border="1" cellpadding="5" cellspacing="0" width="30%" align="right"><tr><td background="/developerworks/i/bg-gold.gif">
	<p><b>Warning: </b>
	<xsl:apply-templates />
	<!-- END OF SIDEBAR -->
	</p>
	</td></tr></table>
</xsl:template>

<xsl:template match="codenote">
	<font color="#ff0000">(Note: <xsl:value-of select="." />)</font>
</xsl:template>

<xsl:template match="comment">
	<font color="#ff0000"><xsl:apply-templates /></font>
</xsl:template>

<xsl:template match="i">
	<b><xsl:apply-templates /></b>
</xsl:template>

<xsl:template match="attribution">
	<i><xsl:apply-templates /></i>
</xsl:template>

<xsl:template match="b">
	<b><xsl:apply-templates /></b>
</xsl:template>

<xsl:template match="body">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="c">
	<b><xsl:apply-templates /></b> 
</xsl:template>

<!-- mertzification -->
<xsl:template match="code">
	<b><xsl:apply-templates /></b> 
</xsl:template>

<xsl:template match="box">
	<p><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="pre">
<xsl:variable name="prenum"><xsl:number level="any" /></xsl:variable>
<xsl:variable name="preid">code<xsl:number level="any" /></xsl:variable>
<p><a name="{$preid}"></a><b><xsl:value-of select="@caption" /></b>
<table border="1" cellpadding="5"  width="100%" cellspacing="0" bgcolor="#cccccc"><tr><td><pre>
<xsl:apply-templates />
</pre></td></tr></table></p>
</xsl:template>

<xsl:template match="path">
	<xsl:value-of select="."/>
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

<!--HTML compat.-->

<xsl:template match="a">
	<a href="{@href}"><xsl:apply-templates /></a>
</xsl:template>

<xsl:template match="p">
	<p><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="e">
	<i><xsl:apply-templates /></i>
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
	<td bgcolor="#ddddff"><xsl:apply-templates /></td>
</xsl:template>

<xsl:template match="th">
	<td bgcolor="#7a5ada"><b><xsl:apply-templates /></b></td>
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

