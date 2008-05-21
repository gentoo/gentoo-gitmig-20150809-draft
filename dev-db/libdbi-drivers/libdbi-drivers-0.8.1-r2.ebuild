# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libdbi-drivers/libdbi-drivers-0.8.1-r2.ebuild,v 1.2 2008/05/21 15:54:57 dev-zero Exp $

inherit eutils

DESCRIPTION="The libdbi-drivers project maintains drivers for libdbi."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libdbi-drivers.sourceforge.net/"
LICENSE="LGPL-2.1"
DEPEND=">=dev-db/libdbi-0.8.0
		mysql? ( virtual/mysql )
		postgres? ( virtual/postgresql-server )
		sqlite? ( <dev-db/sqlite-3 )
		sqlite3? ( >=dev-db/sqlite-3 )
		!bindist? ( firebird? ( dev-db/firebird ) )"

IUSE="mysql postgres sqlite oci8 firebird sqlite3 bindist"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
SLOT=0

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d${S}" epatch "${FILESDIR}"/${P}-oci8.diff
}

pkg_setup() {
	local drivers=""
	use mysql && drivers="${drivers} mysql"
	use postgres && drivers="${drivers} pgsql"
	use sqlite && drivers="${drivers} sqlite"
	use sqlite3 && drivers="${drivers} sqlite3"
	if use firebird; then
		if use bindist; then
			eerror "The Interbase Public License is incompatible with LGPL, see bug #200284."
			eerror "Disabling firebird in the build"
		else
			drivers="${drivers} firebird"
		fi
	fi
	if use oci8; then
		if [ -z "${ORACLE_HOME}" ]; then
			die "\$ORACLE_HOME is not set!"
		fi
		drivers="${drivers} oracle"
	fi
	# safety check
	if [ -z "${drivers// /}" ]; then
		die "No supported databases in your USE flags! (mysql, postgres, sqlite, sqlite3, oracle, firebird)"
	fi
}

src_compile() {
	local myconf=""
	# WARNING: the configure script does NOT work correctly
	# --without-$driver does NOT work
	# so do NOT use `use_with...`
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-pgsql"
	use sqlite && myconf="${myconf} --with-sqlite"
	use sqlite3 && myconf="${myconf} --with-sqlite3"
	use !bindist && use firebird && myconf="${myconf} --with-firebird"
	if use oci8; then
		if [ -z "${ORACLE_HOME}" ]; then
			die "\$ORACLE_HOME is not set!"
		fi
		myconf="${myconf} --with-oracle-dir=${ORACLE_HOME} --with-oracle"
	fi

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README README.osx TODO
}
