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
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td valign="top" height="125" bgcolor="#45347b">
				<table cellspacing="0" cellpadding="0" border="0" width="193">
					<tr><td class="logobg" valign="top" align="center" height="88"><a href="/index.html"><img border="0" src="/images/gtop-s.jpg"/></a></td></tr>
					<tr><td class="logobg" valign="top" align="center" height="36"><a href="/index.html"><img border="0" src="/images/gbot-s.gif"/></a></td></tr>
				</table>
			</td>
<!--			<td width="99%" valign="bottom" bgcolor="#000000">
				<table class="menu" border="0" cellpadding="10" cellspacing="0">
				<tr>
					<td valign="top">
						<xsl:variable name="mylink"><xsl:value-of select="/guide/@link"/></xsl:variable>
						main menu ::<br/>
						&#160;<a class="oldlink" href="/index.html">About Gentoo Linux</a><br/>
						&#160;<a class="oldlink" href="/index-download.html">Download/Install</a><br/> 
						&#160;<a class="oldlink" href="/index-changelog.html">CVS Changelog</a><br/> 
						&#160;<a class="oldlink" href="/index-projects.html">Projects</a><br/> 
						<br/>
					</td>
				</tr>
				<tr>
					<td>
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
		-->
		</tr>
		<tr>
			<td valign="top" align="right" bgcolor="#ffffff">
		
<!--content begin-->

<!--Netscape 4.7 hack table start-->
<!--<table border="0" cellspacing="5" cellpadding="0" height="100%" width="100%">-->
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr><td width="99%" class="content" valign="top" align="left">
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
<!--		<p>
			<xsl:apply-templates select="author"/>

		</p> -->
<form>
	<b>Contents</b>:
	<select name="url" size="1" OnChange="location.href=form.url.options[form.url.selectedIndex].value" style="font-family:Arial,Helvetica, sans-serif; font-size:10">
	<xsl:for-each select="chapter">
		<xsl:variable name="chapid">doc_chap<xsl:number/></xsl:variable>
<!--		<xsl:variable name="me"><xsl:value-of select="/guide/@link"/></xsl:variable>-->
		<option value="#{$chapid}"><xsl:number/>. <xsl:value-of select="title"/></option>
<!--
		&#160;<xsl:number/>&#160;<a class="altlink" href="#{$chapid}"><xsl:value-of select="title"/></a><br/>
	<xsl:value-of select="/guide/@link"/>
	<option value="showdoc.html?i=1514&p=1">Select											

				-->
				</xsl:for-each>		
	</select>
</form>
	


<xsl:apply-templates select="chapter"/> 
<br/>
<br/>
<!--content end-->
</td>
			<td width="1%" bgcolor="#dddaec" valign="top">
				<table border="0" cellspacing="5" cellpadding="0">
				<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
				<tr>
				<td align="center" class="alttext">
					Updated <xsl:value-of select="/guide/date"/>
				</td>
				</tr>
				<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
				<tr>
				<td class="alttext">
				<xsl:apply-templates select="/guide/author"/>
				</td>
				</tr>
				<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
				<tr>
					<td class="alttext">
							<b>Summary:</b>&#160;<xsl:apply-templates select="abstract"/>
					</td>
				</tr> <!--
				<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
				<tr>
				<td class="altmenu">
					Contents:<br/>	
						<xsl:for-each select="chapter">
						<xsl:variable name="chapid">doc_chap<xsl:number/></xsl:variable>
						&#160;<xsl:number/>&#160;<a class="altlink" href="#{$chapid}"><xsl:value-of select="title"/></a><br/>
						</xsl:for-each>		
					</td>
				</tr> -->
				<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
				<tr>
				<td align="center">
					<p class="alttext">Support our development efforts by donating via credit card!</p>
							<!-- Begin PayPal Logo -->
						<form action="https://www.paypal.com/cgi-bin/webscr" methd="post">
						<input type="hidden" name="cmd" value="_xclick"/>
						<input type="hidden" name="business" value="drobbins@gentoo.org"/>
						<input type="hidden" name="item_name" value="Gentoo Linux Support"/>
						<input type="hidden" name="item_number" value="1000"/>
						<input type="hidden" name="image_url" value="http://www.gentoo.org/images/paypal.png"/>
						<input type="hidden" name="no_shipping" value="1"/>
						<input type="hidden" name="return" value="http://www.gentoo.org"/>
						<input type="hidden" name="cancel_return" value="http://www.gentoo.org"/>
						<input type="image" src="http://images.paypal.com/images/x-click-but21.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!"/>
						</form>
						<!-- End PayPal Logo -->
				</td>
				</tr>
				<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
				<tr>
				<td align="center">
					<p class="alttext">Purchase RAM using this link, and a percentage
of your sale will go towards further Gentoo Linux development.</p>
<a href="http://www.qksrv.net/click-477620-5032687" target="_top" ><img src="http://www.qksrv.net/image-477620-5032687" width="125" height="125" alt="DDR Memory at Crucial.com" border="0"/></a>
						<p class="alttext">Why these guys?  Because <b>cvs.gentoo.org</b> and <b>inventor.gentoo.org</b> use high-quality Crucial RAM. We know that it's good stuff because we rely on it ourselves.</p>
</td></tr>
			<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
					</table>
			</td>





</tr></table>
<!--Netscape 4.7 hack end-->
			</td>
		</tr>
		<tr>
			<td align="right" class="infohead" width="100%" bgcolor="#7a5ada">
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
			<td valign="top" height="125" width="1%" bgcolor="#45347b">
				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr><td class="logobg" valign="top" align="center" height="88"><a href="/index.html"><img border="0" src="/images/gtop-s.jpg"/></a></td></tr>
					<tr><td class="logobg" valign="top" align="center" height="36"><a href="/index.html"><img border="0" src="/images/gbot-s.gif"/></a></td></tr>
	</table>
			</td>
			
			<td colspan="2" valign="bottom" align="left" bgcolor="#000000">
				<p class="menu">
					<xsl:choose>
						<xsl:when test="/mainpage/@id='news'">
							<a class="highlight" href="/index.html"> gentoo.org News</a> |
						</xsl:when>
						<xsl:otherwise>
							<a class="menulink" href="/index.html"> gentoo.org News</a> |
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="/mainpage/@id='about'">
							<a class="highlight" href="/index-about.html"> About Gentoo Linux</a> |
						</xsl:when>
						<xsl:otherwise>
							<a class="menulink" href="/index-about.html"> About Gentoo Linux</a> |
						</xsl:otherwise>
					</xsl:choose>
					<a class="menulink" href="/doc/build.html">Download/Install</a> |
					<a class="menulink" href="/doc/faq.html">FAQ</a> |
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
			<td valign="top" align="right" width="1%" bgcolor="#dddaec">
				<!--<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">-->
				<table width="100%" cellspacing="0" cellpadding="0" border="0">
					<tr><td height="1%" valign="top" align="right">
							<img src="/images/gridtest.gif"/>
					</td></tr>
					<tr><td height="99%" valign="top" align="right">
						<!--info goes here-->			
						<table cellspacing="0" cellpadding="5" border="0">
						<!--<table width="90%" height="100%" cellspacing="0" cellpadding="5" border="0">-->
						<tr><td valign="top">
						<p class="altmenu">
						Download Mirrors:<br/>
							<a class="altlink" href="http://www.ibiblio.org/gentoo">ibiblio.org (USA)</a><br/>
							<a class="altlink" href="http://cfx5.tgv.net/">tgv.net (France, high speed)</a><br/>
							<a class="altlink" href="ftp://ftp.ilug-bom.org.in/Linux/distributions/gentoo/">ILUG Bombay (India)</a><br/><br/>
<a href="http://www.qksrv.net/click-477620-5033206" target="_top" >
<img src="http://www.qksrv.net/image-477620-5033206" width="88" height="31" alt="Factory-direct memory upgrades" border="0"/></a><br/><br/>
User Docs:<br/>
						<font color="#ff0000">Updated!</font> <a class="altlink" href="/doc/faq.html">FAQ</a><br/>
						<font color="#ff0000">Updated 18 Oct 2001:</font> <a class="altlink" href="/doc/desktop.html">Desktop Guide</a><br/>
						<font color="#ff0000">Updated!</font> <a class="altlink" href="/doc/portage-user.html">Portage User Guide</a><br/>
						<a class="altlink" href="/doc/openafs.html">OpenAFS Installation Guide</a><br/>
						<font color="#ff0000">Updated!</font> <a class="altlink" href="/doc/build.html">"From Source" CD Install Guide</a><br/>
						<a class="altlink" href="/doc/nvidia_tsg.html">nvidia Troubleshooting Guide</a><br/>
						<br/>
										<a href="http://www.qksrv.net/click-477620-57886" target="_top" >
					<img src="http://www.qksrv.net/image-477620-57886" width="88" height="31" alt="Online Auto Loans" border="0"/></a><br/><br/>	
						Developer Docs:<br/>
						<font color="#ff0000">New!</font> <a class="altlink" href="/doc/cvs-tutorial.html">CVS Tutorial</a><br/>
						<font color="#ff0000">Updated 21 Sep 2001:</font> <a class="altlink" href="/doc/gentoo-howto.html">Development HOWTO</a><br/>
						<a class="altlink" href="/doc/xml-guide.html">XML Documentation Guide</a><br/>
						<br/>
	
						Mailing Lists:<br/><br/>
						<font color="#ff0000">New! General User List:</font><br/> <a class="altlink" href="http://lists.gentoo.org/mailman/listinfo/gentoo-user">gentoo-user</a><br/><br/>
						<font color="#ff0000">New! Ebuild submissions:</font><br/> <a class="altlink" href="http://lists.gentoo.org/mailman/listinfo/gentoo-ebuild">gentoo-ebuild</a><br/><br/>
						
						Developer list:<br/> <a class="altlink" href="http://lists.gentoo.org/mailman/listinfo/gentoo-dev">gentoo-dev</a><br/><br/>
						Announcements:<br/> <a class="altlink" href="http://lists.gentoo.org/mailman/listinfo/gentoo-announce">gentoo-announce</a><br/><br/>
						Daily CVS logs:<br/>  <a class="altlink" href="http://lists.gentoo.org/mailman/listinfo/gentoo-cvs">gentoo-cvs</a><br/><br/>
						<a class="altlink" href="http://lists.gentoo.org">Complete list of mailing lists</a><br/>
						<br/>
						Other Resources:<br/>
						<a class="altlink" href="http://www.gentoo.org/cgi-bin/viewcvs.cgi">viewcvs</a> (browse our repository)<br/>
						IRC: #gentoo on <a class="altlink" href="http://www.openprojects.net/">OPN</a><br/>
						<br/><br/></p></td></tr></table>
					</td></tr>
				</table>
			</td>
			<td valign="top" align="right" bgcolor="#ffffff">
				<table border="0" cellspacing="5" cellpadding="0" width="100%">
				<tr>
					<td class="content" valign="top" align="left">
					<xsl:choose>
						<xsl:when test="/mainpage/@id='news'">
							<img src="/images/gentoo-new.gif"/>
							<br/>
							<br/>
							<xsl:apply-templates select="newsitems"/>
						</xsl:when>
						<xsl:otherwise>
							<p class="subhead"><xsl:value-of select="/mainpage/title"/></p> 
							<br/>
							<xsl:apply-templates select="chapter"/> 
							<br/>
							<br/>
						</xsl:otherwise>
					</xsl:choose>
						<!--content end-->
					</td>
				</tr>
				</table>
			</td>
			<td width="1%" bgcolor="#dddaec" valign="top">
				<table border="0" cellspacing="5" cellpadding="0">
				<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
				<tr>
				<td align="center" class="alttext">
					Updated <xsl:value-of select="/mainpage/date"/>
				</td>
				</tr>
				<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
				<tr>
				<td align="center">
					<p class="alttext">Support our development efforts by donating via credit card!</p>
							<!-- Begin PayPal Logo -->
						<form action="https://www.paypal.com/cgi-bin/webscr" methd="post">
						<input type="hidden" name="cmd" value="_xclick"/>
						<input type="hidden" name="business" value="drobbins@gentoo.org"/>
						<input type="hidden" name="item_name" value="Gentoo Linux Support"/>
						<input type="hidden" name="item_number" value="1000"/>
						<input type="hidden" name="image_url" value="http://www.gentoo.org/images/paypal.png"/>
						<input type="hidden" name="no_shipping" value="1"/>
						<input type="hidden" name="return" value="http://www.gentoo.org"/>
						<input type="hidden" name="cancel_return" value="http://www.gentoo.org"/>
						<input type="image" src="http://images.paypal.com/images/x-click-but21.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!"/>
						</form>
						<!-- End PayPal Logo -->
				</td>
				</tr>
				<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
				<tr>
				<td align="center">
					<p class="alttext">Purchase RAM using this link, and a percentage
of your sale will go towards further Gentoo Linux development.</p>
<a href="http://www.qksrv.net/click-477620-5032687" target="_top" ><img src="http://www.qksrv.net/image-477620-5032687" width="125" height="125" alt="DDR Memory at Crucial.com" border="0"/></a>
						<p class="alttext">Why these guys?  Because <b>cvs.gentoo.org</b> and <b>inventor.gentoo.org</b> use high-quality Crucial RAM. We know that it's good stuff because we rely on it ourselves.</p>
				</td></tr>
			<tr>
				<td>
				<img src="/images/line.gif"/>
				</td>
				</tr>
					</table>
			</td>
			<!--
			<td width="15%" class="infotext" valign="top" align="left" bgcolor="#ddddff">
				<table border="0" cellspacing="5" cellpadding="0" width="100%">
				<tr>
					<td>
						<br/>
					</td>
				</tr>
			</table>
			</td>
			-->
		</tr>
		<tr>
			<td align="right" class="infohead" width="100%" colspan="3" bgcolor="#7a5ada">
			Copyright 2001 Gentoo
		Technologies, Inc.  Questions, Comments, Corrections?  Email <a class="highlight"
		href="mailto:gentoo-dev@gentoo.org">gentoo-dev@gentoo.org</a>.
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
	<table width="100%" border="0" cellspacing="5" cellpadding="0">
	<tr>
		<td colspan="2" class="ncontent" bgcolor="#bbffbb"><p class="note"><font color="#7a5ada"><b><xsl:value-of select="title"/></b></font></p></td>
	</tr>
	<tr>
	<xsl:choose>
		<xsl:when test="@align='left'">
			<td rowspan="2" valign="top" width="1">
				<img src="{@graphic}"/>
			</td>		
			<td class="alttext">
					<font color="#808080">Posted by <xsl:value-of select="poster"/> on <xsl:value-of select="date"/></font>
			</td>
		</xsl:when>
		<xsl:otherwise>
			<td class="alttext">
					<font color="#808080">Posted by <xsl:value-of select="poster"/> on <xsl:value-of select="date"/></font>
			</td>
			<td rowspan="2" valign="top" width="1">
				<img src="{@graphic}"/>
			</td>		
		</xsl:otherwise>
	</xsl:choose>
	</tr>
	<tr>
		<td class="content" valign="top">
			<xsl:apply-templates select="body"/>
		</td>
	</tr>
	</table>
	<br/>
	<table width="100%">
	<tr>
		<td height="1" bgcolor="#c0c0c0"></td>
	</tr>
	</table>
	<br/>
</xsl:template>

<xsl:template match="mail">
	<a href="mailto:{@link}"><xsl:value-of select="."/></a>
</xsl:template>

<xsl:template match="author/mail">
	<b><a class="altlink" href="mailto:{@link}"><xsl:value-of select="."/></a></b>
</xsl:template>

<xsl:template match="author">
	<xsl:apply-templates />
	<xsl:if test="@title"><br/><i><xsl:value-of select="@title"/></i>
	</xsl:if>	
	<br/>
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
	<xsl:apply-templates select="section">
	<xsl:with-param name="chapid" value="$chapid"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="section">
	<xsl:param name="chapid"/>
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

<!--figure without a caption; just a graphical element-->
<xsl:template match="fig">
	<img src="{@link}" alt="{@short}"/>
</xsl:template>

<xsl:template match="br"><br/></xsl:template>

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
	<p class="note"><b>Important: </b>
	<xsl:apply-templates />
	</p>
	</td></tr></table>
</xsl:template>

<xsl:template match="warn">
	<table class="ncontent" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td bgcolor="#ffbbbb">
	<p class="note"><b>Warning: </b>
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

