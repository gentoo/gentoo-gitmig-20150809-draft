# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-ttf/sdl-ttf-2.0.6.ebuild,v 1.7 2003/11/29 21:56:58 brad_mssw Exp $

MY_P="${P/sdl-/SDL_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="library that allows you to use TrueType fonts in SDL applications"
HOMEPAGE="http://www.libsdl.org/projects/SDL_ttf/"
SRC_URI="http://www.libsdl.org/projects/SDL_ttf/release/${MY_P}.tar.gz"

KEYWORDS="x86 ppc sparc alpha amd64"
LICENSE="LGPL-2"
SLOT="0"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/freetype-2.0.1"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc CHANGES README      || die "dodoc failed"
}
