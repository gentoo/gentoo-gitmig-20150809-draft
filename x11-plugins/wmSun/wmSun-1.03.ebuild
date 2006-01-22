# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmSun/wmSun-1.03.ebuild,v 1.11 2006/01/22 12:11:11 nelchael Exp $

IUSE=""

DESCRIPTION="dockapp which displays the rise/set time of the sun"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~mips ppc ~sparc"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )"

src_compile() {
	emake -C wmSun clean || die "make clean failed"
	COPTS=${CFLAGS} emake -C wmSun || die "parallel make failed"
}

src_install() {
	dobin wmSun/wmSun
	doman wmSun/wmSun.1
	dodoc BUGS TODO wmSun/README
}
