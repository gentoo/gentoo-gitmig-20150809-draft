# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/egroupware/egroupware-1.4.004.ebuild,v 1.1 2008/04/25 11:44:10 hollow Exp $

inherit eutils webapp depend.php

MY_PN=eGroupWare

DESCRIPTION="Web-based GroupWare suite"
HOMEPAGE="http://www.egroupware.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}-2.tar.bz2
	mirror://sourceforge/${PN}/${MY_PN}-egw-pear-${PV}-2.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="jpgraph ldap mssql mysql postgres"

RDEPEND="jpgraph? ( || ( dev-php5/jpgraph dev-php4/jpgraph ) )
	dev-php/PEAR-PEAR
	virtual/cron"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"/${PN}

pkg_setup () {
	webapp_pkg_setup
	has_php

	local php_flags="imap session unicode"

	for f in ldap mssql mysql postgres; do
		use ${f} && php_flags="${php_flags} ${f}"
	done

	if ! PHPCHECKNODIE="yes" require_php_with_use ${php_flags} || \
		! PHPCHECKNODIE="yes" require_php_with_any_use gd gd-external ; then
			die "Re-install ${PHP_PKG} with ${php_flags} and either gd or gd-external."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	esvn_clean

	if use jpgraph; then
		einfo "Fixing jpgraph location"
		sed -i "s|EGW_SERVER_ROOT . '/../jpgraph/src/jpgraph.php'|'/usr/share/php${PHP_VERSION}/jpgraph/jpgraph.php'|" \
			projectmanager/inc/class.ganttchart.inc.php || die
		sed -i "s|EGW_SERVER_ROOT . '/../jpgraph/src/jpgraph_gantt.php'|'/usr/share/php${PHP_VERSION}/jpgraph/jpgraph_gantt.php'|" \
			projectmanager/inc/class.ganttchart.inc.php || die
	fi
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned "${MY_HTDOCSDIR}"/phpgwapi/images

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en-1.2.txt
	webapp_src_install
}

pkg_postinst() {
	if use ldap; then
		elog "If you are using LDAP contacts/addressbook, please read the upgrade instructions at"
		elog "http://www.egroupware.org/index.php?page_name=wiki&wikipage=ManualSetupUpdate"
		elog "before running the egroupware setup"
	fi
	webapp_pkg_postinst
}
