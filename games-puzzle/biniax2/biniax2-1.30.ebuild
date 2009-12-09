# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/biniax2/biniax2-1.30.ebuild,v 1.2 2009/12/09 22:43:12 fauli Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Logic game with arcade and tactics modes"
HOMEPAGE="http://biniax.com/"
SRC_URI="http://mordred.dir.bg/biniax/${P}-fullsrc.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[mikmod]"

S=${WORKDIR}

src_prepare() {
	rm -f data/Thumbs.db
	sed -i \
		-e "s:data/:${GAMES_DATADIR}/${PN}/:" \
		desktop/{gfx,snd}.c \
		|| die "sed failed"
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-dotfiles.patch
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "doins failed"
	doicon "${FILESDIR}"/${PN}.xpm
	make_desktop_entry ${PN} Biniax-2
	prepgamesdirs
}
