# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvthread/dvthread-0.4.4.ebuild,v 1.3 2003/03/13 23:18:51 pvdabeel Exp $

A=dvthread-${PV}.tar.gz
S=${WORKDIR}/dvthread-${PV}
DESCRIPTION="dvthread provides classes for threads and monitors, wrapped around the posix thread library"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

inherit eutils

IUSE=""
DEPEND="virtual/glibc"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/gentoo-0.4.4.patch
}

src_install() {
	make prefix=${D}/usr install
}
