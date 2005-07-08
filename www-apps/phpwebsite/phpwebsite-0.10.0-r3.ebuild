# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwebsite/phpwebsite-0.10.0-r3.ebuild,v 1.2 2005/07/08 12:33:47 rl03 Exp $

inherit webapp eutils

MY_P="${PN}-${PV/_p/-}"
DESCRIPTION="phpWebSite Content Management System"
HOMEPAGE="http://phpwebsite.appstate.edu"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-full.tar.gz
http://phpwebsite.appstate.edu/downloads/security/phpws_image_secure_patch.tgz
http://phpwebsite.appstate.edu/downloads/security/phpws_files_security_patch3.tgz
http://phpwebsite.appstate.edu/downloads/security/phpwebsite_security_patch_20050707.1.tgz"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
RDEPEND="virtual/httpd-php
	>=dev-db/mysql-3.23.23"

DEPEND="${DEPEND} ${RDEPEND} >=net-www/webapp-config-1.10-r5"

S="${WORKDIR}/${MY_P}-full"

src_unpack() {
	unpack ${MY_P}-full.tar.gz
	cd ${S}
	unpack phpws_files_security_patch3.tgz
	unpack phpws_image_secure_patch.tgz
	unpack phpwebsite_security_patch_20050707.1.tgz
	epatch ${FILESDIR}/${P}-xml-rpc.diff
}

src_install() {
	webapp_src_preinst

	local docs="docs/CREDITS.txt docs/REQUIREMENTS.txt docs/UNINSTALL.txt docs/THEMES.txt docs/LICENSE.txt docs/README.txt docs/PEARERRORS.txt docs/sample.config.php docs/INSTALL.txt docs/CONVERSION.txt docs/UPGRADE.txt docs/KNOWNISSUES.txt"
	dodoc ${docs}

	einfo "Installing main files"
	cp -r * ${D}${MY_HTDOCSDIR}

	#webapp_configfile ${MY_HTDOCSDIR}/conf/config.php

	# Files that need to be owned by webserver
	webapp_serverowned ${MY_HTDOCSDIR}/conf
	webapp_serverowned ${MY_HTDOCSDIR}/files
	webapp_serverowned ${MY_HTDOCSDIR}/images
	webapp_serverowned ${MY_HTDOCSDIR}/images/mod
	webapp_serverowned ${MY_HTDOCSDIR}/images/mod/controlpanel
	webapp_serverowned ${MY_HTDOCSDIR}/mod

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
