# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-ttf/sdl-ttf-2.0.6.ebuild,v 1.1 2003/06/11 07:00:58 vladimir Exp $

MY_P="${P/sdl-/SDL_}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="library that allows you to use TrueType fonts in SDL applications"
SRC_URI="http://www.libsdl.org/projects/SDL_ttf/release/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/SDL_ttf/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/freetype-2.0.1"

src_compile() {

	econf || die
	emake || die
}

src_install() {

	make prefix=${D}/usr install || die

	dodoc CHANGES COPYING README
}
