# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="The libdbi-drivers project maintains drivers for libdbi."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net/"
LICENSE="LGPL-2.1"
DEPEND="dev-db/libdbi"
IUSE="mysql postgres sqlite oci8"
KEYWORDS="~x86 ~ppc"
SLOT=0

src_compile() {
	local myconf=""
	local drivers=""
	use mysql && drivers="${drivers} mysql" myconf="${myconf} --with-mysql"
	use postgres && drivers="${drivers} pgsql" myconf="${myconf} --with-pgsql"
	use sqlite && drivers="${drivers} sqlite" myconf="${myconf} --with-sqlite"
	use oci8 && [ -n "${ORACLE_HOME}" ]  && myconf="${myconf} --with-oracle --with-oracle-dir=${ORACLE_HOME}" drivers="${drivers} oracle"

	if [ -z "${drivers}" ]; then
		die "You have not specified any supported databases in your use flags (mysql, pgsql, sqlite, oracle)"
	fi

	econf ${myconf}
	emake
}

src_install () {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README README.osx TODO
}
