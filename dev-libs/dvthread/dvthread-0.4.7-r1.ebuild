# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvthread/dvthread-0.4.7-r1.ebuild,v 1.1 2005/05/13 01:32:15 pvdabeel Exp $

inherit eutils

DESCRIPTION="classes for threads and monitors, wrapped around the posix thread library"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/download/${P}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/html/"

KEYWORDS="~x86 ppc"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
}

src_install() {
	make prefix=${D}/usr datadir=${D}/usr/share install
}
