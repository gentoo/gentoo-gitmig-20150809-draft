# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/synaesthesia/synaesthesia-2.1.ebuild,v 1.8 2003/06/12 21:11:14 msterret Exp $

IUSE="sdl svga esd alsa"

S=${WORKDIR}/${P}
DESCRIPTION="a program that represents music graphically in real time as coruscating field of fog and glowing lines"
HOMEPAGE="http://yoyo.cc.monash.edu.au/~pfh/synaesthesia.html"
SRC_URI="http://yoyo.cc.monash.edu.au/~pfh/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11 
	esd? ( >=media-sound/esound-0.2.22 )
	sdl? ( >=media-libs/libsdl-1.2.0 )
	alsa? ( >=media-libs/alsa-lib-0.5.10 )
	svga? ( >=media-libs/svgalib-1.4.3 )"

src_compile() {
	econf || die
	emake || die
}


src_install() {
	dobin synaesthesia
	dodoc README COPYING
}
