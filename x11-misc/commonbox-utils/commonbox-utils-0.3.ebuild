# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/commonbox-utils/commonbox-utils-0.3.ebuild,v 1.11 2004/02/17 23:02:32 agriffis Exp $

DESCRIPTION="Common utilities for fluxbox, blackbox, and openbox"
HOMEPAGE="http://mkeadle.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa ia64"

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
