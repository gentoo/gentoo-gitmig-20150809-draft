# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/commonbox-utils/commonbox-utils-0.5.ebuild,v 1.7 2005/01/08 17:06:46 ka0ttic Exp $

DESCRIPTION="Common utilities for fluxbox, blackbox, and openbox"
HOMEPAGE="http://mkeadle.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"

DEPEND="media-gfx/feh"
RDEPEND="virtual/x11"

src_install() {
	dobin {fbsetbg,commonbox-menugen}
	dodoc README.commonbox-utils AUTHORS COPYING
}

pkg_postinst() {
	commonbox-menugen -kg -o /usr/share/commonbox/menu
	einfo "This version is a complete rewrite, see /usr/share/doc/commonbox-utils-0.5/* for more information."
}
