# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_accounting/mod_accounting-0.5.ebuild,v 1.1 2005/04/21 10:20:56 hollow Exp $

inherit eutils apache-module

DESCRIPTION="This apache module is intended for doing traffic account."
HOMEPAGE="http://mod-acct.sourceforge.net/"
SRC_URI="mirror://sourceforge/mod-acct/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql postgres"

DEPEND="mysql? ( dev-db/mysql ) postgres? ( dev-db/postgresql )"

APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="ACCOUNTING"

DOCFILES="ChangeLog README LICENSE FAQ.txt schema.sql"

need_apache1

src_unpack(){
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd to \$S failed"

	if use mysql; then
		epatch ${FILESDIR}/mod_accounting-0.5-mysql.patch
	elif use postgres; then
		epatch ${FILESDIR}/mod_accounting-0.5-pgsql.patch
	elif use mysql && use postgres; then
		epatch ${FILESDIR}/mod_accounting-0.5-all.patch
	else
		die "choose at least one of mysql or postgres as database driver"
	fi

	epatch ${FILESDIR}/mod_accounting-0.5-fix.patch
}

src_compile() {
	emake || die "emake failed"
}

pkg_postinst() {
	apache-module_pkg_postinst
	einfo "See /usr/share/doc/${PF}/create_tables.sql.gz "
	einfo "on how to create logging tables.\n"
}
