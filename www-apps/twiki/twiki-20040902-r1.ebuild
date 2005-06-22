# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/twiki/twiki-20040902-r1.ebuild,v 1.5 2005/06/22 02:04:08 weeve Exp $

inherit depend.apache webapp-apache

DESCRIPTION="A Web Based Collaboration Platform"
HOMEPAGE="http://twiki.org/"
SRC_URI="http://twiki.org/swd/TWiki${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

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
		insinto ${APACHE2_MODULES_CONFDIR}
	else
		insinto ${APACHE1_MODULES_CONFDIR}
	fi
	doins ${FILESDIR}/twiki.conf 97_twiki.conf

	dodoc readme.txt license.txt
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${D}${destdir}
	chmod 0775 -R ${D}${destdir}/pub  ${D}${destdir}/data
	chown nobody -R ${D}${destdir}/pub ${D}${destdir}/data
	#find ${D}/${HTTPD_ROOT}/${PN}/templates -type d -exec chmod 0440 {} \;
#	chmod 0444 -R ${PN}/templates
}

pkg_postinst() {
	einfo "now go to your ${HTTPD_ROOT}/${PN},"
	einfo "copy bin/.htaccess.txt to bin/.htaccess"
	einfo "and be sure to read"
	einfo "http://localhost/twiki/bin/view/TWiki/TWikiDocumentation#TWiki_Installation_Guide"
}
