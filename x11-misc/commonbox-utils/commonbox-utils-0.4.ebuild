# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/commonbox-utils/commonbox-utils-0.4.ebuild,v 1.13 2005/01/20 17:10:15 j4rg0n Exp $

DESCRIPTION="Common utilities for fluxbox, blackbox, and openbox"
HOMEPAGE="http://mkeadle.org/"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
SRC_URI="http://mkeadle.org/distfiles/${P}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa ~amd64 mips ia64 ~ppc64 ~ppc-macos"

DEPEND="media-gfx/xv"
RDEPEND="virtual/x11"

src_compile() {
	./compile.sh
}

src_install() {
	dobin util/{bsetbg,commonbox-menugen,commonbox-imagebgmenugen}
	dodoc README.commonbox-utils AUTHORS COPYING
	doman bsetbg.1

	insinto /usr/share/commonbox
	doins ${S}/solidbgmenu
}

pkg_postinst() {
	${S}/util/commonbox-imagebgmenugen
	${S}/util/commonbox-menugen -kg -o /usr/share/commonbox/menu
}
