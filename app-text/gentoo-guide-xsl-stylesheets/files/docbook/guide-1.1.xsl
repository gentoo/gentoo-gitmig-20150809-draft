<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>

<xsl:template match="/guide">
    <book>
        <chapter>
            <chapterinfo>
            <xsl:choose>
                <xsl:when test="count(author)=1">
                    <xsl:apply-templates select="author"/>
                </xsl:when>
                <xsl:otherwise>
                    <authorgroup>
                    <xsl:apply-templates select="author"/>
                    </authorgroup>
                </xsl:otherwise>
            </xsl:choose>
            </chapterinfo>

            <title><xsl:value-of select="title"/></title>

            <abstract><para><xsl:value-of select="abstract"/></para></abstract>

            <xsl:apply-templates select="chapter"/>

        </chapter>
    </book>
</xsl:template>

<xsl:template match="author">
<author>
    <othername>
    <xsl:choose>
        <xsl:when test="@email">
            <ulink url="{@email}"><xsl:value-of select="."/></ulink>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="."/>
        </xsl:otherwise>
    </xsl:choose>
    </othername>
     <xsl:if test="@title">
        <affiliation><jobtitle><xsl:value-of select="@title"/></jobtitle></affiliation>
    </xsl:if>
</author>
</xsl:template>

<xsl:template match="chapter">
<sect1>
	<title><xsl:value-of select="title"/></title>
	<xsl:apply-templates select="section"/>
 </sect1>
</xsl:template>

<xsl:template match="section">
<simplesect>
    <title><xsl:value-of select="title"/></title>
	<xsl:apply-templates select="body"/>
 </simplesect>
</xsl:template>

<xsl:template match="body">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="pre">
	<screen>
	<xsl:apply-templates />
	</screen>
</xsl:template>

<xsl:template match="path">
	<filename><xsl:apply-templates /></filename>
</xsl:template>

<xsl:template match="p">
	<para><xsl:apply-templates /></para>
</xsl:template>

<xsl:template match="e">
	<emphasis><xsl:apply-templates /></emphasis>
</xsl:template>

<xsl:template match="link">
	<ulink url="{@path}"><xsl:value-of select="."/></ulink>
</xsl:template>

<xsl:template match="a">
	<ulink url="{@src}"><xsl:value-of select="."/></ulink>
</xsl:template>

<xsl:template match="mail">
	<ulink url="mailto:{@link}"><xsl:value-of select="."/></ulink>
</xsl:template>

<xsl:template match="table">
<table>
    <title><xsl:value-of select="@title"/></title>
    <tgroup cols="{count(tr[position()=1]/td)+count(tr[position()=1]/th)}">
        <thead>
        <xsl:apply-templates select="tr[1]"/>
        </thead>
        <tbody>
        <xsl:apply-templates select="tr[position()>1]"/>
        </tbody>
    </tgroup>
</table>
</xsl:template>


<xsl:template match="tr">
	<row><xsl:apply-templates match="td|th"/></row>
</xsl:template>

<xsl:template match="td">
	<entry><xsl:apply-templates /></entry>
</xsl:template>

<xsl:template match="th">
	<entry><emphasize><xsl:apply-templates /></emphasize></entry>
</xsl:template>


<xsl:template match="note">
<note>
	<title><xsl:value-of select="title"/></title>
	<xsl:apply-templates select="body"/>
 </note>
</xsl:template>
<xsl:template match="important">
<important>
	<title><xsl:value-of select="title"/></title>
	<xsl:apply-templates select="body"/>
 </important>
</xsl:template>

<xsl:template match="warning">
<warning>
	<title><xsl:value-of select="title"/></title>
	<xsl:apply-templates select="body"/>
 </warning>
</xsl:template>



<xsl:template match="code">
	<command><xsl:apply-templates /></command>
</xsl:template>



</xsl:stylesheet>

