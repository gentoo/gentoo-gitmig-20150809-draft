<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/advisory">

<html>
<head>
<title>Gentoo Linux Security Advisory: 
<xsl:value-of select="date/year"/>-<xsl:value-of select="id"/>
</title>
</head>
<body topmargin="0" leftmargin="0" bgcolor="#dddaec">

<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tr><td>

<center>
------------------------------<br/>
Gentoo Linux Security Advisory<br/>
------------------------------<br/>
</center>

</td></tr>
<tr><td>

<!-- inner table -->
<table width="100%" cellspacing="0" cellpadding="5" border="0"
bgcolor="#FFFFFF">
<tr>
<td bgcolor="#7a5ada" colspan="2" width="100%"> 
<center>
<font color="#FFFFFF">Gentoo Linux Security Advisory: <xsl:value-of
select="date/year"/>-<xsl:value-of select="id"/></font>
</center>
</td>
</tr>

<tr>
<td>Packages</td>
<td>
<xsl:for-each select="packages/package">
	<xsl:value-of select="name"/> (<xsl:value-of select="version"/>)<br/>
</xsl:for-each>
</td>
</tr>

<tr>
<td>Date</td>
<td><xsl:value-of select="date/year"/>-<xsl:value-of select="date/month"/>-<xsl:value-of select="date/day"/></td>
</tr>

<tr>
<td>Status</td>
<td><xsl:value-of select="status"/></td>
</tr>

<tr>
<td>Author(s)</td>
<td>
<xsl:for-each select="authors/author">
	<xsl:value-of select="name"/> (<xsl:value-of select="email"/>)<br/>
</xsl:for-each>
</td>
</tr>

<tr>
<td>Description</td> 
<td><xsl:value-of select="description"/></td>
</tr>

<tr>
<td>Impact</td>
<td><xsl:value-of select="impact"/></td>
</tr>

<tr>
<td>Solution</td>
<td><xsl:value-of select="solution"/></td>
</tr>

<xsl:if test="procedure">
<tr>
<td bgcolor="#7a5ada" colspan="2">
<font color="#FFFFFF">Procedure</font>
</td>
</tr>
<tr>
<td colspan="2">
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
</td>
</tr>
</xsl:if>		

</table>
<!-- end of inner table -->

</td></tr>
</table>

</body>
</html>
</xsl:template>
</xsl:stylesheet>

