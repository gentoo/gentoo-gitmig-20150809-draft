# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pipewalker/pipewalker-0.9.1.ebuild,v 1.2 2010/10/17 05:22:09 mr_bones_ Exp $

EAPI=2
inherit flag-o-matic eutils games

DESCRIPTION="Rotating pieces puzzle game"
HOMEPAGE="http://pipewalker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl[opengl,video]
	virtual/opengl
	virtual/glu"

src_prepare() {
	# fix the include of SDL.h (bug #341239)
	epatch "${FILESDIR}"/${P}-sdl-include.patch
	sed -i \
		-e '/OpenGL error:/s/0x/0x%x/' \
		-e '/#pragma warning/d' \
		src/common.h \
		|| die
}

src_configure() {
	append-flags $(sdl-config --cflags)
	egamesconf \
		--disable-dependency-tracking \
		--datadir="${GAMES_DATADIR_BASE}"
}

src_install() {
	emake -C data DESTDIR="${D}" install || die "emake install failed"
	dogamesbin src/${PN} || die "dogamesbin failed"
	doicon extra/${PN}.xpm
	make_desktop_entry ${PN} PipeWalker
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
