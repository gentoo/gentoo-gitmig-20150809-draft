# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdplay/libdvdplay-1.0.1.ebuild,v 1.14 2005/03/04 21:20:51 kito Exp $

IUSE=""

DESCRIPTION="A simple library designed for DVD-menu navigation"
SRC_URI="http://www.videolan.org/pub/${PN}/${PV}/${P}.tar.bz2"
HOMEPAGE="http://developers.videolan.org/libdvdplay/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha ia64 amd64 ~sparc ~ppc-macos"

DEPEND="virtual/libc
	>=media-libs/libdvdread-0.9.3"

src_compile() {
	econf --enable-shared || die
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}
