# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libdbi-drivers/libdbi-drivers-0.8.1-r1.ebuild,v 1.13 2010/09/28 17:22:52 robbat2 Exp $

inherit eutils

DESCRIPTION="The libdbi-drivers project maintains drivers for libdbi."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libdbi-drivers.sourceforge.net/"
LICENSE="LGPL-2.1"
DEPEND=">=dev-db/libdbi-0.8.0
		mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql-base )
		sqlite? ( <dev-db/sqlite-3 )
		sqlite3? ( >=dev-db/sqlite-3 )
		firebird? ( dev-db/firebird )"

IUSE="mysql postgres sqlite oci8 firebird sqlite3"
KEYWORDS="amd64 hppa ppc ~sparc x86"
SLOT=0

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d${S}" epatch "${FILESDIR}"/${P}-oci8.diff
}

src_compile() {
	local myconf=""
	local drivers=""
# WARNING: the configure script does NOT work correctly
# --without-$driver does NOT work
# so do NOT use `use_with...`
	use mysql && drivers="${drivers} mysql" myconf="${myconf} --with-mysql"
	use postgres && drivers="${drivers} pgsql" myconf="${myconf} --with-pgsql"
	use sqlite && drivers="${drivers} sqlite" myconf="${myconf} --with-sqlite"
	use sqlite3 && drivers="${drivers} sqlite3" myconf="${myconf} --with-sqlite3"
	use firebird && drivers="${drivers} firebird" myconf="${myconf} --with-firebird"
	if use oci8; then
		if [ -z "${ORACLE_HOME}" ]; then
			die "\$ORACLE_HOME is not set!"
		fi
		myconf="${myconf} --with-oracle-dir=${ORACLE_HOME} --with-oracle" drivers="${drivers} oracle"
	fi
# safety check
	if [ -z "${drivers}" ]; then
		die "You have not specified any supported databases in your use flags (mysql, pgsql, sqlite, sqlite3, oracle, firebird)"
	fi

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README README.osx TODO
}
src_test() {
	if [ -z "${WANT_INTERACTIVE_TESTS}" ]; then
		ewarn "Tests disabled due to interactivity."
		ewarn "Run with WANT_INTERACTIVE_TESTS=1 if you want them."
		return 0
	fi
	einfo "Running interactive tests"
	emake check || die "Tests failed"
}
