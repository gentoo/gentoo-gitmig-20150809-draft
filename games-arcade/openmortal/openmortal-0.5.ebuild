# Copyright 1999-2004 Gentoo Technologies, Inc., 2004 Freyr Gunnar Ólafsson <gnarlin@utopia.is>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/openmortal/openmortal-0.5.ebuild,v 1.3 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

DESCRIPTION="A spoof of the famous Mortal Combat game"
HOMEPAGE="http://apocalypse.rulez.org/~upi/Mortal/"
SRC_URI="mirror://sourceforge/openmortal/${P}.tar.bz2"
RESTRICT="nomirror"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-net
	>=media-libs/freetype-2.1.0
	dev-lang/perl"

src_install() {
	make DESTDIR="${D}" install         || die "make install failed"
	dodoc AUTHORS ChangeLog TODO README || die "dodoc failed"
	prepgamesdirs
}
