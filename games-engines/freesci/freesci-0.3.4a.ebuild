# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/freesci/freesci-0.3.4a.ebuild,v 1.1 2003/09/09 17:34:21 vapier Exp $

inherit games flag-o-matic

DESCRIPTION="Sierra script interpreter for your old Sierra adventures"
SRC_URI="http://savannah.nongnu.org/download/freesci/stable.pkg/${PV}/${P}.tar.bz2
	http://teksolv.de/~jameson/${P}.tar.bz2"
HOMEPAGE="http://freesci.linuxgames.com/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE="X ggi directfb alsa sdl ncurses"

DEPEND="X? ( virtual/x11 =media-libs/freetype-2* )
	ggi? ( media-libs/libggi )
	directfb? ( dev-libs/DirectFB )
	alsa? ( >=media-libs/alsa-lib-0.5.0 )
	sdl? ( >=media-libs/libsdl-1.1.8 )
	ncurses? ( sys-libs/ncurses )"

src_compile() {
	use X && append-flags -I/usr/include/freetype2
	egamesconf \
		`use_with X x` \
		`use_with sdl` \
		`use_with directfb` \
		`use_with ggi` \
		`use_with alsa` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README README.Unix THANKS TODO
	prepgamesdirs
}
