# Copyright 1999-2003 Gentoo Technologies, Inc., 2003 Freyr Gunnar Ólafsson <gnarlin@utopia.is>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/openmortal/openmortal-0.3.ebuild,v 1.3 2003/10/27 15:11:09 mholzer Exp $

inherit games

DESCRIPTION="A spoof of the famous Mortal Combat game"
HOMEPAGE="http://apocalypse.rulez.org/~upi/Mortal/"
SRC_URI="mirror://sourceforge/openmortal/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	>=media-libs/freetype-2.1.0
	dev-lang/perl"

src_install() {
	emake install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog TODO README
}
