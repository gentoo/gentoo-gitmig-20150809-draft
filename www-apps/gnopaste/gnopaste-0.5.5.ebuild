# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gnopaste/gnopaste-0.5.5.ebuild,v 1.5 2008/02/23 22:28:20 hollow Exp $

inherit webapp depend.php eutils

DESCRIPTION="gnopaste is a nopaste script based on PHP with MySQL"
HOMEPAGE="http://gnopaste.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

need_httpd_cgi
need_php_httpd

src_unpack() {
	unpack ${A}
	cd "${S}"
	esvn_clean
}

pkg_setup() {
	require_php_with_use mysql
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR}"/config.php

	webapp_serverowned "${MY_HTDOCSDIR}"/config.php
	webapp_serverowned "${MY_HTDOCSDIR}"/install.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en-${PV}.txt

	webapp_src_install
}
