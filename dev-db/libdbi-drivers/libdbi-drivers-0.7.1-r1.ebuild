# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libdbi-drivers/libdbi-drivers-0.7.1-r1.ebuild,v 1.1 2005/03/28 00:48:16 robbat2 Exp $

DESCRIPTION="The libdbi-drivers project maintains drivers for libdbi."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net/"
LICENSE="LGPL-2.1"
DEPEND="dev-db/libdbi
		mysql? ( dev-db/mysql )
		postgres? ( dev-db/postgresql )
		sqlite? ( <dev-db/sqlite-3 )"

IUSE="mysql postgres sqlite oci8"
KEYWORDS="~x86 ~ppc ~amd64"
SLOT=0

src_compile() {
	local myconf=""
	local drivers=""
# WARNING: the configure script does NOT work correctly
# --without-$driver does NOT work
# so do NOT use `use_with...`
	use mysql && drivers="${drivers} mysql" myconf="${myconf} --with-mysql"
	use postgres && drivers="${drivers} pgsql" myconf="${myconf} --with-pgsql"
	use sqlite && drivers="${drivers} sqlite" myconf="${myconf} --with-sqlite"
	if use oci8; then
		if [ -z "${ORACLE_HOME}" ]; then
			die "\$ORACLE_HOME is not set!"
		fi
		myconf="${myconf} --with-oracle-dir=${ORACLE_HOME} --with-oracle" drivers="${drivers} oracle"
	fi
# safety check
	if [ -z "${drivers}" ]; then
		die "You have not specified any supported databases in your use flags (mysql, pgsql, sqlite, oracle)"
	fi

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README README.osx TODO
}
