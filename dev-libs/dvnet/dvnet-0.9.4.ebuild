# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvnet/dvnet-0.9.4.ebuild,v 1.1 2003/03/06 18:54:14 pvdabeel Exp $

A=dvnet-${PV}.tar.gz
S=${WORKDIR}/dvnet-${PV}
DESCRIPTION="dvnet provides an interface wrapping sockets into streams"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvnet/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvnet/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL2"
SLOT="0"

DEPEND="virtual/glibc
	dev-libs/dvutil"

src_install() {
	make prefix=${D}/usr install
}
