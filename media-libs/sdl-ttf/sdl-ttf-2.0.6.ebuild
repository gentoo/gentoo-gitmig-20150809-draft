# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-ttf/sdl-ttf-2.0.6.ebuild,v 1.13 2004/08/11 02:43:50 tgall Exp $

inherit eutils gnuconfig

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="library that allows you to use TrueType fonts in SDL applications"
HOMEPAGE="http://www.libsdl.org/projects/SDL_ttf/"
SRC_URI="http://www.libsdl.org/projects/SDL_ttf/release/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ppc64"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/freetype-2.0.1"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/ft2build.patch"
	use ppc64 && gnuconfig_update
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES README
}
