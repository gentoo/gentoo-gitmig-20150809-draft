# Copyriht 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author phoen][x <eqc_phoenix@gmx.de>
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdlmm/sdlmm-0.1.8.ebuild,v 1.1 2002/04/29 04:54:07 rphillips Exp $

MY_P="${P/sdl/SDL}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A C++ Wrapper for the Simple DirectMedia Layer"
SRC_URI="http://prdownloads.sourceforge.net/sdlmm/${MY_P}.tar.bz2"
HOMEPAGE="http://www.libsdl.org/projects/SDL_mixer/index.html"
DEPEND=">=media-libs/libsdl-1.2.4"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING README THANKS
}

