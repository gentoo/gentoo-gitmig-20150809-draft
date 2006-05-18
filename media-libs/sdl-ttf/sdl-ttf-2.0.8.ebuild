# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-ttf/sdl-ttf-2.0.8.ebuild,v 1.1 2006/05/18 17:38:34 mr_bones_ Exp $

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="library that allows you to use TrueType fonts in SDL applications"
HOMEPAGE="http://www.libsdl.org/projects/SDL_ttf/"
SRC_URI="http://www.libsdl.org/projects/SDL_ttf/release/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="X"

DEPEND="X? ( || ( x11-libs/libXt virtual/x11 ) )
	>=media-libs/libsdl-1.2.4
	>=media-libs/freetype-2.0.1"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_with X x) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES README
}
