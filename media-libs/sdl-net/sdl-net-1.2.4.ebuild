# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-net/sdl-net-1.2.4.ebuild,v 1.6 2002/10/04 05:50:28 vapier Exp $

MY_P=${P/sdl-/SDL_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Simple Direct Media Layer Network Support Library"
SRC_URI="http://www.libsdl.org/projects/SDL_net/release/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/SDL_net/index.html"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=media-libs/libsdl-1.2.4"

src_install() {
	einstall || die
	preplib /usr
	dodoc CHANGES COPYING README	
}
