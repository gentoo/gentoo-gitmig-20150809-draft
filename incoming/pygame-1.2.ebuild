# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author David Creswick <davidc@sat.net>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

S=${WORKDIR}/${P}

DESCRIPTION="python bindings to sdl and other libs that facilitate game production"

SRC_URI="http://www.pygame.org/ftp/${P}.tar.gz"

HOMEPAGE="http://www.pygame.org/"

#build-time dependencies
DEPEND="virtual/python
	>=media-libs/libsdl-1.2.0
	>=media-libs/sdl-ttf-2.0.3
	>=media-libs/sdl-image-1.2.0
	>=media-libs/sdl-mixer-1.2.0
	>=dev-python/Numeric-19.0.0
	>=media-libs/smpeg-0.4.4-r1"

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --prefix=${D}/usr || die
	dodoc README.TXT WHATSNEW
}

