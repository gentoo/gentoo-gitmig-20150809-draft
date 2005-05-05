# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/tmw-0.0.12.ebuild,v 1.1 2005/05/05 01:09:05 vapier Exp $

inherit eutils games

DESCRIPTION="A fully free and open source MMORPG game with the looks of \"old-fashioned\" 2D RPG"
HOMEPAGE="http://themanaworld.org"
SRC_URI="mirror://sourceforge/themanaworld/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-games/physfs-1.0.0
	dev-libs/libxml2
	media-libs/sdl-mixer
	media-libs/sdl-image
	>=dev-games/guichan-0.3.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-desktop.patch
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
	prepgamesdirs
}
