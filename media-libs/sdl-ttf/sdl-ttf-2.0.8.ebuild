# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-ttf/sdl-ttf-2.0.8.ebuild,v 1.5 2006/09/02 16:47:57 blubb Exp $

inherit eutils

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="library that allows you to use TrueType fonts in SDL applications"
HOMEPAGE="http://www.libsdl.org/projects/SDL_ttf/"
SRC_URI="http://www.libsdl.org/projects/SDL_ttf/release/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="X"

DEPEND="X? ( || ( x11-libs/libXt virtual/x11 ) )
	>=media-libs/libsdl-1.2.4
	>=media-libs/freetype-2.0.1"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/sdl-ttf-2.0.8-noftinternals.patch
}

src_compile() {
	econf $(use_with X x) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES README
}
