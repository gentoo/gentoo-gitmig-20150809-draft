# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmSun/wmSun-1.03.ebuild,v 1.7 2004/03/26 23:10:07 aliz Exp $

IUSE=""

DESCRIPTION="dockapp which displays the rise/set time of the sun"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~mips"

DEPEND="virtual/x11"

src_compile() {
	emake -C wmSun clean || die "make clean failed"
	COPTS=${CFLAGS} emake -C wmSun || die "parallel make failed"
}

src_install() {
	dobin wmSun/wmSun
	doman wmSun/wmSun.1
	dodoc BUGS TODO wmSun/README
}
