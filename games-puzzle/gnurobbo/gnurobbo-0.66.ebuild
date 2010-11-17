# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gnurobbo/gnurobbo-0.66.ebuild,v 1.1 2010/11/17 18:26:49 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Robbo, a popular Atari XE/XL game ported to Linux"
HOMEPAGE="http://gnurobbo.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnurobbo/${P}-source.tar.gz"

LICENSE="GPL-2 BitstreamVera"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl[audio,video,joystick]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-ttf"

src_prepare() {
	sed -i -e '/^LDFLAGS/d' Makefile || die
}

src_compile() {
	emake \
		PACKAGE_DATA_DIR="${GAMES_DATADIR}/${PN}" \
		BINDIR="${GAMES_BINDIR}" \
		DOCDIR="/usr/share/doc/${PF}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin gnurobbo || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/{levels,skins,locales,rob,sounds} || die "doins failed"
	dodoc AUTHORS Bugs ChangeLog README TODO
	newicon icon32.png ${PN}.png
	make_desktop_entry ${PN} Gnurobbo
	prepgamesdirs
}
