# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-net/sdl-net-1.2.5.ebuild,v 1.10 2004/11/22 05:16:22 vapier Exp $

MY_P=${P/sdl-/SDL_}
DESCRIPTION="Simple Direct Media Layer Network Support Library"
HOMEPAGE="http://www.libsdl.org/projects/SDL_net/index.html"
SRC_URI="http://www.libsdl.org/projects/SDL_net/release/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.5"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES README
}
