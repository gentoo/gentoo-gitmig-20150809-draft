# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-ttf/sdl-ttf-2.0.6.ebuild,v 1.5 2003/10/03 00:40:45 mr_bones_ Exp $

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="library that allows you to use TrueType fonts in SDL applications"
HOMEPAGE="http://www.libsdl.org/projects/SDL_ttf/"
SRC_URI="http://www.libsdl.org/projects/SDL_ttf/release/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/freetype-2.0.1"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	make prefix=${D}/usr install || die "make install failed"
	dodoc CHANGES README         || die "dodoc failed"
}
