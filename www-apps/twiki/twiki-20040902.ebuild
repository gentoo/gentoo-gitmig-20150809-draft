# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/twiki/twiki-20040902.ebuild,v 1.1 2004/11/22 09:42:57 tigger Exp $

inherit webapp-apache

DESCRIPTION="A Web Based Collaboration Platform"
HOMEPAGE="http://twiki.org/"
SRC_URI="http://twiki.org/swd/TWiki${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

S=${WORKDIR}/${PN}

RDEPEND="virtual/php
	media-gfx/graphviz
	dev-db/mysql"

IUSE="apache2"

pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing for ${WEBAPP_SERVER}"
}

src_unpack() {
	unpack ${A}

	cd ${S}

	sed -i -e 's:\/home\/httpd:\/var\/www:g' lib/TWiki.cfg
#	sed -i -e 's:urlpath\/to:var\/www\/localhost\/htdocs:g' \
#		bin/.htaccess.txt
#	echo "Options ExecCGI" >> bin/.htaccess.txt
}


src_install() {
	local destdir=/var/www/twiki

	dodir ${destdir}
	cp -r . ${D}${destdir}

	if use apache2; then
		dodir /etc/apache2/conf/modules.d
		insinto /etc/apache2/conf/modules.d
		newins ${FILESDIR}/twiki.conf 97_twiki.conf
	else
		dodir /etc/apache/conf/addon-modules
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/twiki.conf
	fi

	dodoc readme.txt license.txt
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${D}${destdir}
	chmod 0775 -R ${D}${destdir}/pub  ${D}${destdir}/data
	chown nobody -R ${D}${destdir}/pub ${D}${destdir}/data
	#find ${D}/${HTTPD_ROOT}/${PN}/templates -type d -exec chmod 0440 {} \;
#	chmod 0444 -R ${PN}/templates
}

pkg_postinst() {
	einfo "now go to your ${HTTPD_ROOT}/{PN},"
	einfo "copy bin/.htaccess.txt to bin/.htaccess"
	einfo "and be sure to read"
	einfo "http://localhost/twiki/bin/view/TWiki/TWikiDocumentation#TWiki_Installation_Guide"
}
