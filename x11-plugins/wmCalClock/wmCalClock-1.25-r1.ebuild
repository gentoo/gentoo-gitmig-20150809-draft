# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmCalClock/wmCalClock-1.25-r1.ebuild,v 1.11 2004/07/20 10:43:49 s4t4n Exp $

IUSE=""
S=${WORKDIR}/${P}/Src
DESCRIPTION="WMaker DockApp: A Calendar clock with antialiased text."
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha amd64 ~mips ppc"

S=${WORKDIR}/${P}/Src

src_compile ()
{
	emake CFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install ()
{
	dobin ${PN}
	doman ${PN}.1

	cd ..
	dodoc BUGS CHANGES COPYING HINTS INSTALL README TODO
}
