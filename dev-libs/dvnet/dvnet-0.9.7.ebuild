# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvnet/dvnet-0.9.7.ebuild,v 1.5 2003/07/18 07:54:29 pvdabeel Exp $

A=dvnet-${PV}.tar.gz
S=${WORKDIR}/dvnet-${PV}
DESCRIPTION="dvnet provides an interface wrapping sockets into streams"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvnet/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvnet/html/"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	dev-libs/dvutil"
RDEPEND=${DEPEND}

src_install() {
	make DESTDIR=${D} prefix=${D}/usr install
}
