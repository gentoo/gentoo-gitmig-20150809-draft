# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header

DESCRIPTION="Common utilities for fluxbox, blackbox, and openbox"
HOMEPAGE="http://mkeadle.org/"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
SRC_URI="http://mkeadle.org/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa ~amd64 mips ia64"

DEPEND="media-gfx/xv"
RDEPEND="virtual/x11"

src_compile() {
	./compile.sh
}

src_install() {
	dobin util/{bsetbg,bsetroot,commonbox-menugen,commonbox-imagebgmenugen}
	dodoc README.commonbox-utils AUTHORS COPYING
	doman bsetroot.1 bsetbg.1

	insinto /usr/share/commonbox
	doins ${S}/solidbgmenu
}

pkg_postinst() {
	commonbox-imagebgmenugen
	commonbox-menugen -kg -o /usr/share/commonbox/menu
}
