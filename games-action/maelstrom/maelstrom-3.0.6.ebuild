# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/maelstrom/maelstrom-3.0.6.ebuild,v 1.6 2004/02/20 06:13:56 mr_bones_ Exp $

inherit eutils games

MY_P=Maelstrom-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An asteroids battle game"
SRC_URI="http://www.devolution.com/~slouken/Maelstrom/src/${MY_P}.tar.gz"
HOMEPAGE="http://www.devolution.com/~slouken/Maelstrom/"

KEYWORDS="x86 ppc alpha"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-net-1.2.2"

pkg_setup() {
	games_pkg_setup
}

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-security.patch

	# Remove redundant games in directory
	sed -i -e 's/\/games\//\//g' configure
}

src_install() {
	egamesinstall || die
	dodoc ChangeLog README TODO DIFFERENCES INTERESTING-COMBINATIONS

	insinto /usr/share/pixmaps
	newins ${D}/usr/games/Maelstrom/icon.xpm maelstrom.xpm
	make_desktop_entry Maelstrom "Maelstrom" maelstrom.xpm
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
}
