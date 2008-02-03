# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gnopaste/gnopaste-0.5.5.ebuild,v 1.4 2008/02/03 16:59:41 hollow Exp $

inherit webapp depend.php

DESCRIPTION="It presents a free nopaste system like http://nopaste.info"
HOMEPAGE="http://gnopaste.sf.net/"
LICENSE="GPL-2"

SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="virtual/httpd-cgi
	dev-lang/php"

src_unpack() {
	unpack ${A}
	cd "${S}"
	find . -type d -name '.svn' | xargs rm -rf {} \;
}

pkg_setup() {
	require_php_with_use mysql
	webapp_pkg_setup
}

src_install() {
	# call the eclass, to initialise the image directory for us
	webapp_src_preinst

	elog "Installing main files"
	cp -r . "${D}/${MY_HTDOCSDIR}"

	webapp_configfile "${MY_HTDOCSDIR}/config.php"

	webapp_serverowned "${MY_HTDOCSDIR}/config.php"
	webapp_serverowned "${MY_HTDOCSDIR}/install.php"

	webapp_postinst_txt en "${FILESDIR}/postinstall-en-${PV}.txt"

	webapp_src_install
}
