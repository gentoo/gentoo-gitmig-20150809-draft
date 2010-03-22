# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/postfixadmin/postfixadmin-2.3.ebuild,v 1.2 2010/03/22 20:56:39 jlec Exp $

inherit eutils webapp depend.php confutils

DESCRIPTION="Web Based Management tool for Postfix style virtual domains and users."
HOMEPAGE="http://postfixadmin.sourceforge.net"
MY_P="${PN}_${PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="extras mysql postgres tests"

DEPEND="dev-perl/DBI
	virtual/perl-MIME-Base64
	dev-perl/Email-Valid
	dev-perl/Mail-Sender
	dev-perl/log-dispatch
	dev-perl/Log-Log4perl
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )"
RDEPEND="${DEPEND}"

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup

	confutils_require_any mysql postgres

	if use mysql; then
		enewgroup vacation
		enewuser vacation -1 -1 -1 vacation
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	ecvs_clean
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

		mv VIRTUAL_VACATION/INSTALL.TXT VIRTUAL_VACATION_INSTALL.TXT
		dodoc VIRTUAL_VACATION_INSTALL.TXT
		rm VIRTUAL_VACATION_INSTALL.TXT
	fi

	local docs="DOCUMENTS/*.txt CHANGELOG.TXT INSTALL.TXT"
	dodoc ${docs}

	if ! use extras; then
		rm -rf ADDITIONS/
	fi

	if ! use tests; then
		rm -rf tests
	fi

	for FILE in DOCUMENTS/ GPL-LICENSE.TXT LICENSE.TXT debian/
	do
	  rm -rf ${FILE}
	done

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR}"/config.inc.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en-2.3.txt
	webapp_src_install
}
