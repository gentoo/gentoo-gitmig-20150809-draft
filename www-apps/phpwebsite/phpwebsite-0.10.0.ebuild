# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwebsite/phpwebsite-0.10.0.ebuild,v 1.1 2004/11/24 19:14:57 rizzo Exp $

inherit webapp

MY_PV="${PV/_p/-}"
DESCRIPTION="phpWebSite Content Management System"
HOMEPAGE="http://phpwebsite.appstate.edu"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}-full.tar.gz"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
RDEPEND="virtual/httpd-php
	>=dev-db/mysql-3.23.23"

DEPEND="${DEPEND} ${RDEPEND} >=net-www/webapp-config-1.10-r5"

S="${WORKDIR}/${PN}-${MY_PV}-full"

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
