# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwebsite/phpwebsite-0.10.1-r1.ebuild,v 1.3 2005/07/09 01:08:59 weeve Exp $

inherit eutils webapp

DESCRIPTION="phpWebSite Content Management System"
HOMEPAGE="http://phpwebsite.appstate.edu"
SRC_URI="mirror://sourceforge/${PN}/${P}-full.tar.gz
http://phpwebsite.appstate.edu/downloads/security/phpwebsite_security_patch_20050707.1.tgz"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha ppc sparc x86"
IUSE=""
RDEPEND="virtual/httpd-php
	>=dev-db/mysql-3.23.23"

DEPEND="${DEPEND} ${RDEPEND} >=net-www/webapp-config-1.11"

S="${WORKDIR}/${P}-full"

src_unpack() {
	unpack ${P}-full.tar.gz
	cd ${S}
	unpack phpwebsite_security_patch_20050707.1.tgz
	epatch ${FILESDIR}/phpwebsite-0.10.0-xml-rpc.diff
}

src_install() {
	webapp_src_preinst

	local docs="docs/CHANGELOG.txt docs/CONVERSION.txt docs/CREDITS.txt docs/INSTALL.txt docs/KNOWNISSUES.txt docs/PEARERRORS.txt docs/README.txt docs/REQUIREMENTS.txt docs/THEMES.txt docs/UNINSTALL.txt docs/UPGRADE.txt	docs/sample.config.php"
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
