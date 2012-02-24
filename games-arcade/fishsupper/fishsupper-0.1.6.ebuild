# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/fishsupper/fishsupper-0.1.6.ebuild,v 1.3 2012/02/24 14:34:52 phajdan.jr Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A simple arcade/puzzle game, loosely based on the retro classic Frogger"
HOMEPAGE="http://sourceforge.net/projects/fishsupper/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5 GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/libsdl[audio,video,opengl,X]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[wav]
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-libs/boost"

src_configure() {
	egamesconf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README

	newicon data/images/fs_sprite_042.png ${PN}.png
	make_desktop_entry ${PN} "Fish Supper"

	prepgamesdirs
}
