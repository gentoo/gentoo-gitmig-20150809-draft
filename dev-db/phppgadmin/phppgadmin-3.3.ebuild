# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phppgadmin/phppgadmin-3.3.ebuild,v 1.2 2004/03/21 22:46:26 nakano Exp $

inherit eutils
inherit webapp-apache

IUSE=""

# This package insists on uppercase letters
MY_PN=phpPgAdmin
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="Web-based administration for Postgres database in php"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://phppgadmin.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="0"

DEPEND=">=dev-db/postgresql-7.0.0
	>=dev-php/mod_php-4.1"

pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_compile() {
	mv libraries/lib.inc.php ${T}/lib.inc.php
	mv login.php ${T}/login.php
	sed -e "s|conf/config.inc.php|/etc/phppgadmin/config.inc.php|g" \
		${T}/login.php > login.php
	sed -e "s|include('./conf|include('conf|g" \
		-e "s|conf/config.inc.php|/etc/phppgadmin/config.inc.php|g" \
		${T}/lib.inc.php > libraries/lib.inc.php
}

src_install() {
	webapp-detect || NO_WEBSERVER=1
	webapp-mkdirs

	for doc in DEVELOPERS FAQ HISTORY INSTALL TODO TRANSLATORS \
		CREDITS BUGS
	do
		dodoc $doc
		rm -f $doc
	done
	rm -f LICENSE

	dodir /etc/phppgadmin
	mv conf/* sql/* ${D}/etc/phppgadmin/
	rm -fr config/ sql/

	dodir ${HTTPD_ROOT}/phppgadmin
	cp -ar * ${D}${HTTPD_ROOT}/phppgadmin/
}

pkg_postinst() {
	einfo
	einfo "Make sure you edit ${ROOT}/etc/phppgadmin/config.inc.php"
	einfo
	einfo "To use the reports-database, you have to manually execute"
	einfo "psql -f /etc/phppgadmin/reports-pgsql.sql"
	einfo
}
