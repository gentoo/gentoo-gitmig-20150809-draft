# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/freesci/freesci-0.6.1.ebuild,v 1.2 2004/03/31 20:57:05 dholm Exp $

inherit games

DESCRIPTION="Sierra script interpreter for your old Sierra adventures"
HOMEPAGE="http://freesci.linuxgames.com/"
SRC_URI="http://www-plan.cs.colorado.edu/reichenb/freesci/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="X ggi directfb alsa sdl ncurses"

RDEPEND="virtual/glibc
	X? (
		virtual/x11
		=media-libs/freetype-2*
	)
	ggi? ( media-libs/libggi )
	directfb? ( dev-libs/DirectFB )
	alsa? ( >=media-libs/alsa-lib-0.5.0 )
	sdl? ( >=media-libs/libsdl-1.1.8 )
	ncurses? ( sys-libs/ncurses )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/^SUBDIRS/ s/conf debian//" Makefile.in \
			|| die "sed Makefile.in failed"
}
src_compile() {
	egamesconf \
		`use_with X x` \
		`use_with sdl` \
		`use_with directfb` \
		`use_with ggi` \
		`use_with alsa` \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README README.Unix THANKS TODO
	prepgamesdirs
}
