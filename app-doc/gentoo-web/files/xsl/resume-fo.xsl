<?xml version='1.0' encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:output encoding="iso-8859-1" method="xml" indent="yes"/> 

<xsl:template match="/resume">
<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<fo:layout-master-set>
		<fo:simple-page-master master-name="US-Letter" page-height="11in" page-width="8.5in" margin-top="0.5in" margin-bottom="0.5in" margin-left="1.0in"  margin-right="1.0in">
			<fo:region-body/>
		</fo:simple-page-master>
	</fo:layout-master-set>
  	<fo:page-sequence master-name="US-Letter">

		<fo:flow flow-name="xsl-region-body">
		<fo:block font-size="18pt" 
				font-family="Times Roman" 
				font-variant="small-caps"
				font-weight="bold"
				line-height="24pt"
				text-align="center"
				padding-top="3pt">
		<xsl:apply-templates select="name"/>
		</fo:block>
		<fo:block font-size="10pt" 
				font-family="Times Roman" 
				text-align="center">
		<xsl:apply-templates select="contactinfo"/>
		</fo:block>
		<fo:block font-size="16pt" 
				font-family="Times Roman" 
				font-variant="small-caps"
				padding-top="3pt">
				Experience
		</fo:block>
		<fo:block text-align="justify">
			<xsl:apply-templates select="employer"/>	
		</fo:block>
		</fo:flow>
	</fo:page-sequence>
</fo:root>
</xsl:template>

<xsl:template match="name">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="contactinfo">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="line">
	<fo:block><xsl:apply-templates/></fo:block>
</xsl:template>

<xsl:template match="employer">
	<fo:block font-size="10pt" start-indent="0.25cm"
				font-family="Times Roman" 
				font-weight="bold"
				padding-top="0.25cm"
				border-bottom-style="solid"
				border-bottom-width="0.1pt"
				>
	<xsl:apply-templates select="name"/>
	</fo:block>
	<xsl:apply-templates select="position"/>
</xsl:template>

<xsl:template match="position">
	<fo:block padding-top="0.25cm" start-indent="0.5cm">
	<fo:table>
		<fo:table-column column-width="3.25in"/>
		<fo:table-column column-width="3.25in"/>
		<fo:table-body>
		<fo:table-row>
		<fo:table-cell>
		<fo:block font-size="10pt" 
			font-family="Times Roman" 
			font-weight="bold"
			font-variant="small-caps">
			<xsl:apply-templates select="title"/> 
		</fo:block>
		</fo:table-cell>
		<fo:table-cell>
		<fo:block text-align="end" font-size="10pt" 
			font-family="Times Roman" 
			font-variant="small-caps">
			<xsl:value-of select="start"/> to <xsl:value-of select="stop"/>
		</fo:block>
		</fo:table-cell>
		</fo:table-row>
		</fo:table-body>
	</fo:table>
		<fo:block font-size="9pt" 
			font-family="Times Roman" 
			padding-top="3pt">
			<xsl:apply-templates select="body"/>
		</fo:block>
	</fo:block>
</xsl:template>

<xsl:template match="body">
	<xsl:apply-templates /> 
</xsl:template>

<xsl:template match="p">
	<fo:block><xsl:apply-templates /></fo:block>
</xsl:template>

<xsl:template match="e">
	<fo:inline font-style="italic"><xsl:apply-templates /></fo:inline>
</xsl:template> 
</xsl:stylesheet>
