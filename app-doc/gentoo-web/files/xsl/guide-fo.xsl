<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml"/> 

<xsl:template match="/guide">
<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="Times Roman" font-size="12pt" text-align="justify">
  <fo:layout-master-set>
 
    <fo:simple-page-master master-name="simple1" page-width="8.5in" page-height="11in" margin-top="1in" margin-bottom="1in" margin-left="10pc" margin-right="1in">
      <fo:region-body margin-bottom="24pt" margin-top="24pt"/>
      <fo:region-before extent="0pt"/>
      <fo:region-after extent="0pt"/>
    </fo:simple-page-master>

    <fo:page-sequence-master master-name="oneside1">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-name="simple1"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
 
  </fo:layout-master-set>

  <fo:page-sequence hyphenate="true" master-name="oneside1" language="en">
    <fo:flow flow-name="xsl-region-body">
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"/>
      <fo:block id="id2626599">
        <fo:block background-color="black">
          <fo:external-graphic src="file:gentoo-doc.eps" content-width="auto" content-height="auto" width="auto" height="auto"/>
        </fo:block>
        <fo:block background-color="green">
        documentation :: <xsl:value-of select="title"/>
        </fo:block>
      </fo:block>
    </fo:flow>
  </fo:page-sequence>
</fo:root>
</xsl:template>
</xsl:stylesheet>