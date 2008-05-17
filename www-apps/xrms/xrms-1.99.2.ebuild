# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/xrms/xrms-1.99.2.ebuild,v 1.5 2008/05/17 08:31:17 wrobel Exp $

inherit webapp depend.php eutils

MY_DATE="2006-07-25"

DESCRIPTION="Advanced Customer Relationship Management (CRM) and Sales Force Automation (SFA) suite"
HOMEPAGE="http://xrms.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_DATE}-v${PV}-.tar.gz"

LICENSE="OSL-2.0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-php/PEAR-PEAR"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"/${PN}

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use mysql
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	ecvs_clean
}

src_install () {
	webapp_src_preinst

	dodoc CHANGELOG README install/INSTALL
	rm -f CHANGELOG README install/INSTALL LICENSE

	insinto "${MY_HOSTROOTDIR}"/${PF}
	doins -r include/
	rm -rf include/

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned "${MY_HTDOCSDIR}"/{export,storage,tmp}

	webapp_configfile "${MY_HTDOCSDIR}"/include-locations.inc
	webapp_configfile "${MY_HOSTROOTDIR}"/${PF}/include/vars.php
	webapp_configfile "${MY_HOSTROOTDIR}"/${PF}/include/plugin-cfg.php
	webapp_configfile "${MY_HOSTROOTDIR}"/${PF}/include/classes/SMTPs/SMTPs.ini.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade-en.txt
	webapp_hook_script "${FILESDIR}"/reconfig

	webapp_src_install
}
