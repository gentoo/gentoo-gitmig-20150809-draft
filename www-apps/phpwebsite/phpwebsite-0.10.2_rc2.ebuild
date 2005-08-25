# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwebsite/phpwebsite-0.10.2_rc2.ebuild,v 1.2 2005/08/25 14:45:15 gustavoz Exp $

inherit webapp

MY_PV=${PV/_rc/-RC}

DESCRIPTION="phpWebSite Content Management System"
HOMEPAGE="http://phpwebsite.appstate.edu"
SRC_URI="http://phpwebsite.appstate.edu/downloads/rc/${PN}-${MY_PV}.tar.gz"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~ppc sparc ~x86"
IUSE=""
RDEPEND="virtual/httpd-php
	>=dev-db/mysql-3.23.23"

DEPEND="${DEPEND} ${RDEPEND} >=net-www/webapp-config-1.11"

S="${WORKDIR}/${PN}-${MY_PV}"

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
