# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@gentoo.org>
# Author: Ulf Grossekathoefer <ugrossek@web.de>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

S=${WORKDIR}/${P}

DESCRIPTION="a program that represents music graphically in real time as coruscating field of fog and glowing lines"

SRC_URI="http://yoyo.cc.monash.edu.au/~pfh/${P}.tar.gz"

HOMEPAGE="http://yoyo.cc.monash.edu.au/~pfh/synaesthesia.html"

DEPEND="virtual/glibc
	virtual/x11 
	esd? ( >=media-sound/esound-0.2.22 )
	alsa? ( >=media-libs/alsa-lib-0.5.10 )
	sdl? ( >=media-libs/libsdl-1.2.0 )
	svga? ( >=media-libs/svgalib-1.4.3 )"

src_compile() {
	./configure --prefix=/usr || die
	emake || die
}


src_install() {
	dobin synaesthesia
	dodoc README COPYING
}

