# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/gwiz/gwiz-0.8.ebuild,v 1.1 2003/09/10 06:26:50 vapier Exp $

DESCRIPTION="clone of old-school Wizardry(tm) games by SirTech"
SRC_URI="http://icculus.org/gwiz/${P}.tar.bz2"
HOMEPAGE="http://icculus.org/gwiz/"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=media-libs/libsdl-1.2.3
	>=media-libs/sdl-image-1.2.1-r1
	>=media-libs/sdl-ttf-2.0.4"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog README doc/HOWTO-PLAY
}
