# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libdbi-drivers/libdbi-drivers-0.7.1.ebuild,v 1.5 2004/10/06 18:48:39 swegener Exp $

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

	econf ${myconf} || die "econf failed"
	emake
}

src_install () {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README README.osx TODO
}
