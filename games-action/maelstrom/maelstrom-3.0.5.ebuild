# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/maelstrom/maelstrom-3.0.5.ebuild,v 1.4 2004/06/24 21:56:48 agriffis Exp $

MY_P=Maelstrom-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An asteroids battle game"
SRC_URI="http://www.devolution.com/~slouken/Maelstrom/src/${MY_P}.tar.gz"
HOMEPAGE="http://www.devolution.com/~slouken/Maelstrom/"

KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-net-1.2.2"

src_install() {
	einstall || die
	dodoc ChangeLog README TODO DIFFERENCES INTERESTING-COMBINATIONS
}
