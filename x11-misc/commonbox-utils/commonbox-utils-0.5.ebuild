# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header

DESCRIPTION="Common utilities for fluxbox, blackbox, and openbox"
HOMEPAGE="http://mkeadle.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa ~amd64"

DEPEND="media-gfx/feh"
RDEPEND="virtual/x11"

src_install() {
	dobin util/{fbsetbg,commonbox-menugen}
	dodoc README.commonbox-utils AUTHORS COPYING
}

pkg_postinst() {
	commonbox-menugen -kg -o /usr/share/commonbox/menu
	einfo "This version is a complete rewrite, see /usr/share/doc/commonbox-utils-0.5/* for more information."
}
