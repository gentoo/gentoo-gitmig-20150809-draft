# Copyright 1999-2001 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/gentoo-web/gentoo-web-2.2.ebuild,v 1.53 2002/05/15 17:09:29 drobbins Exp $
 
# WARNING: THIS EBUILD SHOULD BE EDITED BY DANIEL ROBBINS ONLY
 
TEMPLATE="xsl/guide-main.xsl"
S=${WORKDIR}/gentoo-src/gentoo-web
DESCRIPTION="www.gentoo.org website"
SRC_URI="http://www.red-bean.com/cvs2cl/cvs2cl.pl"
HOMEPAGE="http://www.gentoo.org"
RDEPEND="virtual/python dev-libs/libxslt"
WEBROOT=/www/virtual/www.gentoo.org/htdocs

src_unpack() {
	if [ "$MAINTAINER" != "yes" ]
	then
		echo "This will zap stuff in ${WEBROOT}."
		echo "Beware -- maintainers only."
	fi
	cd ${WORKDIR}/${P}
	local myhost
	myhost=`hostname`
	if [ "$myhost" = "inventor.gentoo.org" ]
	then
		ln -s /home/drobbins/gentoo-src gentoo-src
	elif [ "$myhost" = "chiba.3jane.net" ]
		cvs -d /home/cvsroot co gentoo-src
	else
		die "This ebuild has not been tweaked for your system."
	fi
}

src_install() {
	dodir ${WEBROOT}/doc
	dodir ${WEBROOT}/projects
	insinto ${WEBROOT}/doc
	cd ${S}
	local x
	for x in mirroring gentooppc-quickstart use-howto gentoo-security rc-scripts java eclass-howto build desktop xml-guide portage-manual portage-user gentoo-howto faq nvidia_tsg openafs cvs-tutorial shots ebuild-submit altinstall uml nano-basics-guide build-fr desktop-fr portage-manual-fr portage-user-fr faq-fr nvidia_tsg-fr altinstall-fr rc-scripts-fr
	do
		xsltproc $TEMPLATE xml/${x}.xml > ${D}${WEBROOT}/doc/${x}.html || die
	done
	dodir ${WEBROOT}/images
	insinto ${WEBROOT}/images
	cp -a ${S}/images ${D}/${WEBROOT}
	local x
	cd images
	for x in shots/desktop*.png
	do
		[ "${x%*small.png}" != "${x}" ] && continue
		sed -e "s:TITLE:${x}:" -e "s:IMG:http\://www.ibiblio.org/gentoo/images/${x}:" ${S}/html/shell.html > ${D}${WEBROOT}/images/${x%.png}.html
	done
	
	insinto ${WEBROOT}
	doins favicon.ico
	
	#dynamic firewalls tools page
	cd ${S}
	xsltproc $TEMPLATE xml/dynfw.xml > ${D}${WEBROOT}/projects/dynfw.html	|| die
	xsltproc $TEMPLATE xml/project-xml.xml > ${D}${WEBROOT}/projects/xml.html	|| die
	
	#resume
	xsltproc xsl/resume-html.xsl xml/resume.xml > ${D}${WEBROOT}/resume.html || die
	
	#both URLs should work
	dodir ${WEBROOT}/projects/keychain
	xsltproc $TEMPLATE xml/keychain.xml > ${D}${WEBROOT}/projects/keychain.html || die	
	xsltproc $TEMPLATE xml/keychain.xml > ${D}${WEBROOT}/projects/keychain/index.html	|| die
	
	insinto ${WEBROOT}/projects
	doins dynfw/dynfw-1.0.1.tar.gz 
	
	cd ..
	tar czvf ${D}${WEBROOT}/projects/guide-xml-latest.tar.gz gentoo-web 
	cd ${S}
	dodir ${WEBROOT}/news	
	local mydate
	mydate=`date +"%d %b %Y"`
	echo "<?xml version='1.0'?>" > ${T}/main-news.xml
	echo '<mainpage id="news"><title>Gentoo Linux News</title><author title="Author"><mail link="drobbins@gentoo.org">Daniel Robbins</mail></author>' >> ${T}/main-news.xml
	echo "<version>1.0</version><date>${mydate}</date><newsitems>" >> ${T}/main-news.xml
	local myext
	for x in `find xml/news -iname 200*.xml | sort -r`
	do
		myext=`basename $x`
		myext=${myext%*.xml}
		cat $x | sed -e "1d" -e "s:<news:<news external=\"/news/${myext}.html\":" >> ${T}/main-news.xml
		xsltproc xsl/guide-main.xsl $x > ${D}/${WEBROOT}/news/${myext}.html
	done
	echo "</newsitems></mainpage>" >> ${T}/main-news.xml
	insinto ${WEBROOT}
	xsltproc $TEMPLATE ${T}/main-news.xml > ${D}${WEBROOT}/index.html || die
	xsltproc $TEMPLATE xml/main-about.xml > ${D}${WEBROOT}/index-about.html || die
	xsltproc $TEMPLATE xml/main-download.xml > ${D}${WEBROOT}/index-download.html || die
	xsltproc $TEMPLATE xml/main-projects.xml > ${D}${WEBROOT}/index-projects.html || die
	xsltproc $TEMPLATE xml/main-docs.xml > ${D}${WEBROOT}/index-docs.html || die
	xsltproc $TEMPLATE xml/main-articles.xml > ${D}${WEBROOT}/index-articles.html || die
	xsltproc $TEMPLATE xml/main-contract.xml > ${D}${WEBROOT}/index-contract.html || die
	xsltproc $TEMPLATE xml/main-graphics.xml > ${D}${WEBROOT}/index-graphics.html || die
	python python/genpkgxml.py ${T}/main-packages.xml || die
	xsltproc $TEMPLATE ${T}/main-packages.xml > ${D}${WEBROOT}/index-packages.html || die
	doins css/main-new.css css/resume.css
	
	#install XSL for later use
	dodir ${WEBROOT}/xsl
	insinto ${WEBROOT}/xsl
	cd ${S}/xsl
	doins cvs.xsl guide-main.xsl

	#install snddevices script
	dodir ${WEBROOT}/scripts
	insinto ${WEBROOT}/scripts
	cd ${S}/scripts
	doins snddevices

	dobin ${DISTDIR}/cvs2cl.pl
	dosbin ${S}/bin/cvslog.sh

	insinto ${WEBROOT}
	doins ${S}/txt/robots.txt

	cd ${D}
	chmod -R +r *

	insinto ${WEBROOT}/snapshots
	newins ${S}/html/index.html-snapshots index.html
}

pkg_preinst() {
	if [ -d ${WEBROOT}.bak ]
	then
		rm -rf ${WEBROOT}.bak
	fi
	if [ -d ${WEBROOT} ]
	then
		cp -ax ${WEBROOT} ${WEBROOT}.bak
	fi
}

pkg_postinst() {
	if [ "`hostname`" = "chiba.3jane.net" ]
	then
		echo '>>> Syncing up images to ibiblio...'
		su - drobbins rsync -ave ssh ${WEBROOT}/images drobbins@login.ibiblio.org:gentoo/images/
	fi
}
