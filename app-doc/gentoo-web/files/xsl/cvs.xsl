<?xml version='1.0' encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="iso-8859-1" method="xml" indent="yes"/>

<xsl:template match="/changelog">
	<mainpage id="changelog">
	<title>Gentoo Linux Development Changelog for <xsl:value-of select="entry/date"/></title>
	<author title="script">cvs-xml.xsl</author>

	<standout>
		<title>About the Development Changelog</title>
		<body>
			This page contains a daily Changelog, listing all modifications made to our
			CVS tree on <xsl:value-of select="entry/date"/> (yesterday).
		</body>
	</standout>
	<version>1.0.0</version>
	<date><xsl:value-of select="entry/date"/></date>
	<chapter>
		<xsl:apply-templates select="entry"/>
	</chapter>
	</mainpage>
</xsl:template>

<xsl:template match="entry">
	<section>
		<title>Files modified by <xsl:value-of select="author"/> at <xsl:value-of select="time"/></title>
		<body>
			<note><xsl:value-of select="msg"/></note>
			<ul>
				<xsl:apply-templates select="file"/>
			</ul>
		</body>
	</section>
</xsl:template>

<xsl:template match="file">
	<li><path><xsl:value-of select="name"/></path>, <xsl:value-of select="revision"/></li>
</xsl:template>

</xsl:stylesheet>

