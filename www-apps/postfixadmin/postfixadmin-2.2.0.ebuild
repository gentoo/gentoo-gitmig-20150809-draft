# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/postfixadmin/postfixadmin-2.2.0.ebuild,v 1.2 2009/06/08 17:21:48 dertobi123 Exp $

inherit eutils webapp depend.php confutils

DESCRIPTION="Web Based Management tool for Postfix style virtual domains and users."
HOMEPAGE="http://high5.net/postfixadmin/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres"

DEPEND=">=dev-lang/perl-5.0
	dev-perl/DBI
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )"
RDEPEND="${DEPEND}"

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup

	confutils_require_any mysql postgres
	confutils_use_depend_built_with_all mysql mail-mta/postfix mysql
	confutils_use_depend_built_with_all postgres mail-mta/postfix postgres

	if use mysql; then
		enewgroup vacation
		enewuser vacation -1 -1 -1 vacation
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	ecvs_clean

	mv VIRTUAL_VACATION/INSTALL.TXT VIRTUAL_VACATION_INSTALL.TXT
}

src_install() {
	webapp_src_preinst

	# virtual vacation only works with MySQL
	if use mysql; then
		diropts -m0770 -o vacation -g vacation
		dodir /var/spool/vacation
		keepdir /var/spool/vacation
		insinto /var/spool/vacation
		insopts -m770 -o vacation -g vacation
		doins "${S}"/VIRTUAL_VACATION/vacation.pl

		diropts -m775 -o root -g root
		insopts -m644 -o root -g root
	fi

	local docs="DOCUMENTS/BACKUP_MX.txt CHANGELOG.TXT INSTALL.TXT
		DOCUMENTS/LANGUAGE.txt DOCUMENTS/UPGRADE.txt
		VIRTUAL_VACATION_INSTALL.TXT"
	dodoc ${docs}

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	for FILE in ${docs} GPL-LICENSE.TXT LICENSE.TXT ADDITIONS/ debian/
	do
	  rm -rf ${FILE}
	done

	webapp_configfile "${MY_HTDOCSDIR}"/config.inc.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en-2.2.0.txt
	webapp_src_install
}
