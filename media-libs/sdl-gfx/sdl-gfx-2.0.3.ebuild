# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-gfx/sdl-gfx-2.0.3.ebuild,v 1.2 2002/07/23 00:49:50 seemant Exp $

MY_P="${P/sdl-/SDL_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Graphics drawing primitives library for SDL"
SRC_URI="http://www.ferzkopp.net/Software/SDL_gfx-2.0/${MY_P}.tar.gz"
HOMEPAGE="http://www.ferzkopp.net/Software/SDL_gfx-2.0/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

DEPEND=">=media-libs/libsdl-1.2"

CFLAGS="${CFLAGS} -O2"

src_compile() {
	
	econf || die
	emake || die
}

src_install() {

	einstall || die
}
