# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvthread/dvthread-0.4.6a.ebuild,v 1.1 2003/07/14 20:23:49 pvdabeel Exp $

inherit eutils

DESCRIPTION="classes for threads and monitors, wrapped around the posix thread library"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/download/${P}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/html/"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
}

src_install() {
	make prefix=${D}/usr install || die
}
