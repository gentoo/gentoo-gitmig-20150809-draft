# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmCalClock/wmCalClock-1.25.ebuild,v 1.7 2004/04/30 21:58:35 pvdabeel Exp $

DESCRIPTION="WMaker DockApp: A Calendar clock with antialiased text."
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc"

DEPEND="virtual/x11"

S=${WORKDIR}/${P}/Src

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin /usr/man/man1
	make DESTDIR=${D}/usr install || die
}
