# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author David Creswick <davidc@sat.net>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

${S}=${WORKDIR}/SDL_ttf-${PV}

DESCRIPTION="library that allows you to use TrueType fonts in SDL applications"

SRC_URI="http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-2.0.3.tar.gz"

HOMEPAGE="http://www.libsdl.org/projects/SDL_ttf/"

#build-time dependencies
DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/freetype-2.0.1"

src_compile() {
	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make prefix=${D}/usr install || die
	dodoc CHANGES COPYING README
}
