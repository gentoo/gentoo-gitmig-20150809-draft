# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gnurobbo/gnurobbo-0.57.ebuild,v 1.6 2008/11/01 17:52:01 nixnut Exp $

inherit eutils games

DESCRIPTION="Robbo, a popular Atari XE/XL game ported to Linux"
HOMEPAGE="http://gnurobbo.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnurobbo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	unpack ./*.bz2
}

src_compile() {
	egamesconf --disable-dependency-tracking || die
	sed -i \
		-e "/PACKAGE_DATA_DIR/s:\".*\":\"${GAMES_DATADIR}/${PN}/\":" \
		config.h \
		|| die "sed failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS Bugs ChangeLog README TODO
	newicon "${WORKDIR}"/${PN}.48.png ${PN}.png
	make_desktop_entry ${PN} Gnurobbo
	prepgamesdirs
}
