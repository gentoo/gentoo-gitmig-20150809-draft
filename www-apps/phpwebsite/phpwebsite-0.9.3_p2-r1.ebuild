# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwebsite/phpwebsite-0.9.3_p2-r1.ebuild,v 1.2 2004/09/03 17:17:21 pvdabeel Exp $

inherit webapp-apache

IUSE="apache2"
MY_PV="${PV/_p/-}"
S="${WORKDIR}/${PN}-${MY_PV}-full"
DESCRIPTION="phpWebSite provides a complete web site content management system. Web-based administration allows for easy maintenance of interactive, community-driven web sites."
HOMEPAGE="http://phpwebsite.appstate.edu"
SRC_URI="mirror://sourceforge/phpwebsite/${PN}-${MY_PV}-full.tar.gz
		http://phpwsbb.sourceforge.net/Database0932.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc alpha"

DEPEND=">=sys-devel/patch-2.5.9"
RDEPEND="virtual/php
		 dev-db/mysql"


pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing for ${WEBAPP_SERVER}"
}

src_unpack() {
	unpack ${PN}-${MY_PV}-full.tar.gz
	cd ${S}/core/
	unpack Database0932.zip
}

src_install() {
	webapp-mkdirs

	dodir "${HTTPD_ROOT}/phpwebsite"
	cp -a * "${D}/${HTTPD_ROOT}/phpwebsite"
	dodoc ${S}/docs/*.txt
	dodoc ${S}/docs/*.php
	dodoc ${S}/docs/developers/*.txt
	dodoc ${S}/docs/developers/*.php

	#cd "${D}/${HTTPD_ROOT}"
	chown -R "${HTTPD_USER}:${HTTPD_GROUP}" "${D}/${HTTPD_ROOT}/phpwebsite"
	chmod 0775 "${D}/${HTTPD_ROOT}/phpwebsite"
	find "${D}/${HTTPD_ROOT}/phpwebsite/" -type d | xargs chmod 2775
	find "${D}/${HTTPD_ROOT}/phpwebsite/" -type f | xargs chmod 0664
	chmod 0555 "${D}/${HTTPD_ROOT}/phpwebsite/setup/*.sh"
}

pkg_postinst() {
	einfo
	einfo "You will need to create a database for phpWebSite"
	einfo "on your own before starting setup."
	einfo
	#einfo "cd ${HTTPD_ROOT}/phpwebsite/setup"
	#einfo "./secure_setup.sh setup"
	#einfo
	einfo "Once you have a database ready proceed to"
	einfo "http://$HOSTNAME/phpwebsite to continue installation."
	einfo
	einfo "Once you are done with installation you need to run"
	einfo
	einfo "cd ${HTTPD_ROOT}/phpwebsite/setup"
	einfo "./secure_phpws.sh run apache users"
	einfo
}
