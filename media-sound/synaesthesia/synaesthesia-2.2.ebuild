# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/synaesthesia/synaesthesia-2.2.ebuild,v 1.1 2004/01/14 05:47:35 vapier Exp $

DESCRIPTION="a nice graphical accompanyment to music"
HOMEPAGE="http://yoyo.cc.monash.edu.au/~pfh/synaesthesia.html"
SRC_URI="http://www.logarithmic.net/pfh/Synaesthesia/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="sdl svga esd"

DEPEND="virtual/x11
	esd? ( >=media-sound/esound-0.2.22 )
	sdl? ( >=media-libs/libsdl-1.2.0 )
	svga? ( >=media-libs/svgalib-1.4.3 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/CFLAGS=/s:-O4:${CFLAGS}:" \
		-e "/CXXFLAGS=/s:-O4:${CXXFLAGS}:" \
		configure
	sed -i 's:void inline:inline void:' syna.h
}

src_install() {
	dobin synaesthesia || die
	dodoc README
}
