# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gnurobbo/gnurobbo-0.57.ebuild,v 1.1 2005/03/02 05:26:40 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Robbo, a popular Atari XE/XL game ported to Linux"
HOMEPAGE="http://gnurobbo.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnurobbo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	bunzip2 -v *bz2
	mv gnurobbo.48.png "${T}/${PN}.png"
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
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS Bugs ChangeLog README TODO
	doicon "${T}/${PN}.png"
	make_desktop_entry gnurobbo Gnurobbo ${PN}.png
	prepgamesdirs
}
