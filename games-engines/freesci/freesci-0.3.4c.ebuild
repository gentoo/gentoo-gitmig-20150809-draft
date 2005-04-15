# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/freesci/freesci-0.3.4c.ebuild,v 1.4 2005/04/15 04:05:28 vapier Exp $

inherit flag-o-matic games

DESCRIPTION="Sierra script interpreter for your old Sierra adventures"
HOMEPAGE="http://freesci.linuxgames.com/"
SRC_URI="http://www-plan.cs.colorado.edu/creichen/freesci/${P}.tar.bz2
	http://teksolv.de/~jameson/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X ggi directfb alsa sdl ncurses"

RDEPEND="virtual/libc
	X? (
		virtual/x11
		=media-libs/freetype-2*
	)
	ggi? ( media-libs/libggi )
	directfb? ( dev-libs/DirectFB )
	alsa? ( >=media-libs/alsa-lib-0.5.0 )
	sdl? ( >=media-libs/libsdl-1.1.8 )
	ncurses? ( sys-libs/ncurses )"
DEPEND="${RDEPEND}"

src_compile() {
	sed -i -e 's:DSPF_RGB15:DSPF_ARGB1555:' src/gfx/drivers/directfb_driver.c
	use X && append-flags -I/usr/include/freetype2
	egamesconf \
		$(use_with X x) \
		$(use_with sdl) \
		$(use_with directfb) \
		$(use_with ggi) \
		$(use_with alsa) \
		|| die
	sed -i \
		-e "/^datadir/ s:/games::" desktop/Makefile \
		|| die "sed desktop/Makefile failed"
	sed -i \
		-e '/^datadir/ s:$(prefix):/usr:' conf/Makefile \
		|| die "sed conf/Makefile failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}/usr/games/share"
	dodoc AUTHORS ChangeLog NEWS README README.Unix THANKS TODO
	prepgamesdirs
}
