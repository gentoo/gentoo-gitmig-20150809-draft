<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/advisory">

<html>
<body>

<center>
------------------------------<br/>
Gentoo Linux Security Advisory<br/>
------------------------------<br/>
</center>

<p>
Gentoo Linux is a free x86-based community developed Linux distribution
with an advanced package management system (called Portage).  Since it may
be possible for users to use different versions of the same package, it is
important that users carefully read this announcement to assess the impact
of the problem on their systems and choose a workaround or solution that
matches their situation.
</p>

<dl>
<dt>Advisory ID</dt>
<dd><xsl:value-of select="date/year"/>-<xsl:value-of select="id"/></dd>

<dt>Packages</dt>
<xsl:for-each select="packages/package">
	<dd><xsl:value-of select="name"/> (<xsl:value-of select="version"/>)</dd>
</xsl:for-each>

<dt>Date</dt>
<dd><xsl:value-of select="date/year"/>-<xsl:value-of select="date/month"/>-<xsl:value-of select="date/day"/></dd>

<dt>Status</dt>
<dd><xsl:value-of select="status"/></dd>

<dt>Author(s)</dt>
<xsl:for-each select="authors/author">
	<dd><xsl:value-of select="name"/> (<xsl:value-of select="email"/>)</dd>
</xsl:for-each>

<dt>Description</dt> 
<dd><xsl:value-of select="description"/></dd>

<dt>Impact</dt>
<dd><xsl:value-of select="impact"/></dd>

<dt>Solution</dt>
<dd><xsl:value-of select="solution"/></dd>

<xsl:if test="procedure">
<dt>Procedure</dt>
	<ul>
	<xsl:for-each select="procedure/step">
		<li><xsl:value-of select="text"/></li>
		<ul>
		<xsl:for-each select="example">	
			<li><i><xsl:value-of select="."/></i></li>
		</xsl:for-each>
		</ul>
	</xsl:for-each>
	</ul>
</xsl:if>		

</dl>

</body>
</html>
</xsl:template>
</xsl:stylesheet>

