<?xml version='1.0' encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="iso-8859-1" method="html" indent="yes"/> 
<xsl:preserve-space elements="pre"/>

<xsl:template match="/guide">
<html>
<head>
    <link title="new" rel="stylesheet" href="/main-new.css" type="text/css"></link>
<title>Gentoo Linux 
	<xsl:choose>
	<xsl:when test="/guide/@type='project'">
		Projects
	</xsl:when>
	<xsl:otherwise>
		Documentation
	</xsl:otherwise>
	</xsl:choose>
-- 
	<xsl:choose>
		<xsl:when test="subtitle">
			<xsl:value-of select="title"/>: <xsl:value-of select="subtitle"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="title"/>
		</xsl:otherwise>
	</xsl:choose>
</title>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" bgcolor="#ffffff">
	<!--<table border="0" width="100%" cellspacing="0" cellpadding="0">-->
	<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td valign="top" height="168" width="30%" bgcolor="#45347b">
				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr><td class="logobg" valign="top" align="center" height="120"><a href="/index.html"><img src="/images/gtop-new.jpg"/></a></td></tr>
					<tr><td class="logobg" valign="top" align="center" height="48"><a href="/index.html"><img src="/images/gbot-new.gif"/></a></td></tr>
				</table>
			</td>
			<td valign="bottom" height="168" width="70%" bgcolor="#000000">
				<!--Netscape 4.7 table hack-->
				<table class="menu" border="0" cellpadding="10" cellspacing="0" width="100%">
				<tr>
					<td valign="top">
						<xsl:variable name="mylink"><xsl:value-of select="/guide/@link"/></xsl:variable>
						main menu ::<br/>
						&#160;<a class="oldlink" href="/index.html">About Gentoo Linux</a><br/>
						&#160;<a class="oldlink" href="/index-download.html">Download/Install</a><br/> 
						&#160;<a class="oldlink" href="http://cvs.gentoo.org/wiki">Dev Wiki</a><br/> 
						&#160;<a class="oldlink" href="/index-changelog.html">CVS Changelog</a><br/> 
						&#160;<a class="oldlink" href="/index-projects.html">Projects</a><br/> 
						<br/>
					</td>
					<td valign="top">
						toc ::<br/>	
						<xsl:for-each select="chapter">
						<xsl:variable name="chapid">doc_chap<xsl:number/></xsl:variable>
						&#160;<a class="oldlink" href="#{$chapid}"><xsl:value-of select="title"/></a><br/>
						</xsl:for-each>		
					</td>
					<td valign="top">
						summary ::<br/>
							<font color="#00ff00"><xsl:apply-templates select="abstract"/></font>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<xsl:choose>
						<xsl:when test="/guide/@type='project'">
							projects
						</xsl:when>
						<xsl:otherwise>
							docs 
						</xsl:otherwise>
						</xsl:choose>
						::
						<a class="highlight" href="{$mylink}">
						<xsl:choose>
						<xsl:when test="/guide/subtitle">
							<xsl:value-of select="/guide/title"/>: <xsl:value-of select="/guide/subtitle"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/guide/title"/>
						</xsl:otherwise>
						</xsl:choose>
						</a>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" height="96" align="right" width="30%" bgcolor="#ffffff">
		
<!--content begin-->

<!--Netscape 4.7 hack table start-->
<!--<table border="0" cellspacing="5" cellpadding="0" height="100%" width="100%">-->
<table border="0" cellspacing="5" cellpadding="0" width="100%">
<tr><td class="content" valign="top" align="left">
			<br/>
			<p class="dochead">
			<xsl:choose>
				<xsl:when test="/guide/subtitle">
					<xsl:value-of select="/guide/title"/>: <xsl:value-of select="/guide/subtitle"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/guide/title"/>
				</xsl:otherwise>
			</xsl:choose>
			</p>
		<p>
			<xsl:apply-templates select="author"/>

		</p>
<xsl:apply-templates select="chapter"/> 
<br/>
<br/>
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

<xsl:template match="/mainpage">
<html>
<head>
    <link title="new" rel="stylesheet" href="/main-new.css" type="text/css"></link>
	<title>Gentoo Linux -- <xsl:value-of select="title"/></title>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" bgcolor="#ffffff">
	<!--<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">-->
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td rowspan="2" valign="top" height="168" width="30%" bgcolor="#45347b">
				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr><td class="logobg" valign="top" align="center" height="120"><a href="/index.html"><img src="/images/gtop-new.jpg"/></a></td></tr>
					<tr><td class="logobg" valign="top" align="center" height="48"><a href="/index.html"><img src="/images/gbot-new.gif"/></a></td></tr>
				</table>
			</td>
			
			<td valign="middle" align="center" width="70%" bgcolor="#000000">
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="center">
						<p class="infotext"><font color="#00ff00"><br/><a href="http://www.qksrv.net/click-477620-5032686" target="_top" ><img src="http://www.qksrv.net/image-477620-5032686" width="468" height="60" alt="DDR Memory at Crucial.com" border="0"/></a><br/><b>inventor</b> and <b>cvs.gentoo.org</b> use Crucial RAM; click above, buy some... and support <i>us</i>!</font></p>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="bottom" align="left" width="70%" bgcolor="#000000">
			<p class="menu">
				<xsl:choose>
					<xsl:when test="/mainpage/@id='about'">
						<a class="highlight" href="/index.html"> About Gentoo Linux</a> |
					</xsl:when>
					<xsl:otherwise>
						<a class="menulink" href="/index.html"> About Gentoo Linux</a> |
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="/mainpage/@id='download'">
						<a class="highlight" href="/index-download.html">Download/Install</a> | <a class="menulink" href="http://cvs.gentoo.org/wiki">Dev Wiki</a> |
					</xsl:when>
					<xsl:otherwise>
						<a class="menulink" href="/index-download.html">Download/Install</a> | <a class="menulink" href="http://cvs.gentoo.org/wiki">Dev Wiki</a> |
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="/mainpage/@id='changelog'">
						<a class="highlight" href="/index-changelog.html">CVS Changelog</a> |
					</xsl:when>
					<xsl:otherwise>
						<a class="menulink" href="/index-changelog.html">CVS Changelog</a> |
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="/mainpage/@id='projects'">
						<a class="highlight" href="/index-projects.html">Projects</a>
					</xsl:when>
					<xsl:otherwise>
						<a class="menulink" href="/index-projects.html">Projects</a>
					</xsl:otherwise>
				</xsl:choose>
				</p>
			</td>
		</tr>
		<tr>
			<td valign="top" height="96" align="right" width="30%" bgcolor="#dddaec">
				<!--<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">-->
				<table width="100%" cellspacing="0" cellpadding="0" border="0">
					<tr><td height="1%" valign="top" align="right"><img src="/images/gridtest.gif"/></td></tr>
					<tr><td height="99%" valign="top" align="center">
						<!--info goes here-->			
						<table width="90%" cellspacing="0" cellpadding="5" border="0">
						<!--<table width="90%" height="100%" cellspacing="0" cellpadding="5" border="0">-->
						<tr><td class="infotext" valign="top">
						<p class="infosub">Download Sites:</p>
						<p class="infolist"><a href="http://www.ibiblio.org/gentoo">ibiblio.org mirror</a></p>
						<p class="infolist"><a href="http://download.sourceforge.net/pub/mirrors/metalab/Linux/distributions/gentoo/">SourceForge mirror</a></p>

						<p class="infosub">User Documentation:</p>
						<p class="infolist"><font color="#ff0000"><b>New!</b></font><a href="/doc/desktop.html">Gentoo Linux Desktop Guide</a></p>
						<p class="infolist"><font color="#ff0000"><b>New!</b></font><a href="/doc/build.html">Gentoo Linux 1.0_rc5 Build CD Install Guide</a></p>
						<p>(you can find the i686 Binary CD Install Guide <a href="/index-download.html">here</a>)</p>
						<p class="infolist"><a href="/doc/faq.html">Gentoo Linux FAQ</a></p>
						<p class="infolist"><a href="/doc/portage-user.html">Portage User Guide</a></p>
						<p class="infolist"><a href="/doc/nvidia_tsg.html">nvidia Troubleshooting Guide</a></p>
						
						<p class="infosub">Developer Documentation:</p>
						<p class="infolist"><a href="/doc/xml-guide.html">Gentoo Linux Documentation Guide</a></p>
						<p class="infolist"><a href="/doc/gentoo-howto.html">Development HOWTO</a></p>

	
						<p class="infosub">Mailing Lists (click to subscribe/access archive):</p>
						<p class="infolist"><a href="http://cvs.gentoo.org/mailman/listinfo/gentoo-dev">Developer discussion</a></p>
						<p class="infolist"><a href="http://cvs.gentoo.org/mailman/listinfo/gentoo-announce">Announcements</a></p>
						<p class="infolist"><a href="http://cvs.gentoo.org/mailman/listinfo/gentoo-cvs">Daily CVS log</a></p>

												<p class="infosub">Other Resources:</p>
						<p class="infolist">Use <a href="http://cvs.gentoo.org/cgi-bin/cvsweb.cgi">cvsweb</a> to browse our repository</p>
						<p class="infolist">IRC: #gentoo on <a href="http://www.openprojects.net/">irc.openprojects.net</a></p>
						</td></tr></table>
					</td></tr>
				</table>
			</td>
			<td valign="top" height="96" align="right" width="30%" bgcolor="#ffffff">
		
<!--content begin-->

<!--Netscape 4.7 hack table start-->
<!--<table border="0" cellspacing="5" cellpadding="0" height="100%" width="100%">-->
<table border="0" cellspacing="5" cellpadding="0" width="100%">
<tr><td class="content" valign="top" align="left">
	<xsl:if test="/mainpage/standout">
	<table class="infotab" width="50%" align="right" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="infohead" align="center" bgcolor="#7a5ada"><xsl:value-of select="/mainpage/standout/title"/></td>
		</tr>
		<tr valign="top" bgcolor="#ddddff">
			<td class="infotext">
				<xsl:apply-templates select="/mainpage/standout/body"/>
			</td>
		</tr>
	</table>
	</xsl:if>
		<img src="/images/gentoo-new.gif"/><br/>
		<p class="subhead"><xsl:value-of select="/mainpage/title"/></p>
<xsl:apply-templates select="chapter"/> 
<br/>
<br/>
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
	<xsl:choose>
	<xsl:when test="title">
		<p class="chaphead"><font class="chapnum"><a name="{$chapid}"><xsl:number/>.</a></font> <xsl:value-of select="title"/></p>
	</xsl:when>
	<xsl:otherwise>
		<xsl:if test="/guide">
			<p class="chaphead"><font class="chapnum"><a name="{$chapid}"><xsl:number/>.</a></font></p> 
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

<xsl:template match="figure">
	<xsl:variable name="fignum"><xsl:number level="any"/></xsl:variable>
	<xsl:variable name="figid">doc_fig<xsl:number/></xsl:variable>
	<br/>
	<a name="{$figid}"/>
	<table cellspacing="0" cellpadding="0" border="0">
	<tr><td class="infohead" bgcolor="#7a5ada">
	<p class="caption">
		<xsl:choose>
			<xsl:when test="@caption">
				Figure <xsl:value-of select="$fignum"/>: <xsl:value-of select="@caption" />
			</xsl:when>
			<xsl:otherwise>
				Figure <xsl:value-of select="$fignum"/>
			</xsl:otherwise>
		</xsl:choose>
	</p>
	</td></tr>
	<tr><td align="center" bgcolor="#ddddff">
	<xsl:choose>
		<xsl:when test="@short">
			<img src="{@link}" alt="Fig. {$fignum}: {@short}"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="{@link}" alt="Fig. {$fignum}"/>
		</xsl:otherwise>
	</xsl:choose>
	</td></tr></table>
	<br/>
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
	<font class="comment">// <xsl:value-of select="." /></font>
</xsl:template>

<xsl:template match="comment">
	<font class="comment"><xsl:apply-templates /></font>
</xsl:template>

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

<xsl:template match="c">
	<font class="code"><xsl:apply-templates /></font> 
</xsl:template>

<xsl:template match="box">
	<p class="infotext"><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="pre">
	<xsl:variable name="prenum"><xsl:number level="any" /></xsl:variable>
	<xsl:variable name="preid">doc_pre<xsl:number level="any" /></xsl:variable>
	<a name="{$preid}"/>
	<table class="ntable" width="100%" cellspacing="0" cellpadding="0" border="0">
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

<xsl:template match="p">
	<p><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="e">
	<font class="emphasis"><xsl:apply-templates /></font>
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

