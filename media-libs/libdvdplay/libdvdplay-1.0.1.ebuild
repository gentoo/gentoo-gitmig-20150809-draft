# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdplay/libdvdplay-1.0.1.ebuild,v 1.7 2004/04/09 23:13:15 lv Exp $

IUSE=""

S="${WORKDIR}/${P}"

DESCRIPTION="A simple library designed for DVD-menu navigation"
SRC_URI="http://www.videolan.org/pub/${PN}/${PV}/${P}.tar.bz2"
HOMEPAGE="http://developers.videolan.org/libdvdplay/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc alpha ia64 ~amd64"

DEPEND="virtual/glibc
	>=media-libs/libdvdread-0.9.3"

src_compile() {
	econf --enable-shared || die
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}
