# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvmysql/dvmysql-0.4.7.ebuild,v 1.1 2003/03/06 18:54:14 pvdabeel Exp $

A=dvmysql-${PV}.tar.gz
S=${WORKDIR}/dvmysql-${PV}
DESCRIPTION="dvmysql provides a C++ interface to mysql"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvmysql/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvmysql/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL2"
SLOT="0"

DEPEND="virtual/glibc
	dev-db/mysql
	dev-libs/dvutil"

src_install() {
	make prefix=${D}/usr install
}
