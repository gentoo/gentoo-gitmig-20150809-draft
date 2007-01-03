# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/xrms/xrms-1.99.2.ebuild,v 1.1 2007/01/03 00:50:48 rl03 Exp $

inherit webapp depend.php

MY_DATE="2006-07-25"
DESCRIPTION="XRMS is a fully-integrated suite of web-based tools for Customer Relationship Management (CRM), Sales Force Automation (SFA), and Business Intelligence (BI) tools."
HOMEPAGE="http://xrms.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_DATE}-v${PV}-.tar.gz"

LICENSE="OSL-2.0"
KEYWORDS="~x86"
S="${WORKDIR}/${PN}"

IUSE="intl"

RDEPEND="
	>=virtual/php-4.3.0
	dev-php/PEAR-PEAR
"

pkg_setup() {
	webapp_pkg_setup
	local php_flags="mysql"

	use intl && php_flags="${php_flags} nls recode"
	require_php_with_use ${php_flags}
}

src_unpack() {
	unpack ${A}; cd ${S}
	# Remove .cvs* files and CVS directories
	find -name .cvs\* -or \( -type d -name CVS -prune \) | xargs rm -rf
}

src_install () {
	webapp_src_preinst

	dodir "${MY_HOSTROOTDIR}/${PF}"
	dodoc CHANGELOG README LICENSE install/INSTALL

	cp -R . "${D}/${MY_HTDOCSDIR}"
	mv "${D}/${MY_HTDOCSDIR}/include" "${D}/${MY_HOSTROOTDIR}/${PF}"

	local files="export storage tmp"
	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_configfile "${MY_HOSTROOTDIR}/${PF}/include/vars.php"
	webapp_configfile "${MY_HTDOCSDIR}/include-locations.inc"
	webapp_configfile "${MY_HOSTROOTDIR}/${PF}/include/plugin-cfg.php"
	webapp_configfile "${MY_HOSTROOTDIR}/${PF}/include/classes/SMTPs/SMTPs.ini.php"

	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"
	webapp_postupgrade_txt en "${FILESDIR}/postupgrade-en.txt"
	webapp_hook_script "${FILESDIR}/reconfig"

	webapp_src_install
}
