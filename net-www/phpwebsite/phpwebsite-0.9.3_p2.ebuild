# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/phpwebsite/phpwebsite-0.9.3_p2.ebuild,v 1.1 2003/12/16 02:41:53 rizzo Exp $

inherit webapp-apache

MY_PV="${PV/_p/-}"
S="${WORKDIR}/${PN}-${MY_PV}-full"
DESCRIPTION="phpWebSite provides a complete web site content management system. Web-based administration allows for easy maintenance of interactive, community-driven web sites."
HOMEPAGE="http://phpwebsite.appstate.edu"
SRC_URI="mirror://sourceforge/phpwebsite/${PN}-${MY_PV}-full.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND=">=sys-devel/patch-2.5.9"
RDEPEND="virtual/php
		 dev-db/mysql"

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing for ${WEBAPP_SERVER}"
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
