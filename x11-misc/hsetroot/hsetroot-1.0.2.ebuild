# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/hsetroot/hsetroot-1.0.2.ebuild,v 1.3 2004/12/05 09:13:36 swegener Exp $

IUSE=""
DESCRIPTION="Tool which allows you to compose wallpapers ('root pixmaps') for X"
SRC_URI="http://thegraveyard.org/files/${P}.tar.gz"
HOMEPAGE="http://thegraveyard.org/hsetroot.php"

DEPEND="virtual/x11
	>=media-libs/imlib2-1.0.6.2003*
	>=media-libs/imlib2_loaders-1.0.4.2003*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	econf || die
	emake all || die
}

src_install () {
	dobin src/hsetroot
	dodoc README
}
