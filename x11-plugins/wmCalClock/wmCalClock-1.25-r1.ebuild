# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmCalClock/wmCalClock-1.25-r1.ebuild,v 1.15 2005/11/10 08:48:03 s4t4n Exp $

IUSE=""

DESCRIPTION="WMaker DockApp: A Calendar clock with antialiased text."
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha amd64 ~mips ppc ppc64"

S=${WORKDIR}/${P}/Src

src_unpack()
{
	unpack ${A}
	cd ${S}

	# remove unneeded SYSTEM variable from Makefile, fixing bug #105730
	cd ${S}
	sed -i -e "s:\$(SYSTEM)::" Makefile
}

src_compile()
{
	emake CFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install()
{
	dobin ${PN}
	doman ${PN}.1

	cd ..
	dodoc BUGS CHANGES HINTS README TODO
}
