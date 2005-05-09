# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/gwiz/gwiz-0.8.ebuild,v 1.7 2005/05/09 13:31:18 dholm Exp $

DESCRIPTION="clone of old-school Wizardry(tm) games by SirTech"
HOMEPAGE="http://icculus.org/gwiz/"
SRC_URI="http://icculus.org/gwiz/${P}.tar.bz2"

KEYWORDS="x86 ~alpha ~amd64 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.3
	>=media-libs/sdl-image-1.2.1-r1
	>=media-libs/sdl-ttf-2.0.4"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README doc/HOWTO-PLAY
}
