# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvthread/dvthread-0.4.4.ebuild,v 1.1 2003/03/06 18:54:14 pvdabeel Exp $

A=dvthread-${PV}.tar.gz
S=${WORKDIR}/dvthread-${PV}
DESCRIPTION="dvthread provides classes for threads and monitors, wrapped around the posix thread library"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL2"
SLOT="0"

DEPEND="virtual/glibc"

src_install() {
	make prefix=${D}/usr install
}
