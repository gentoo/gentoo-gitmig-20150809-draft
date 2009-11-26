# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gnurobbo/gnurobbo-0.62.ebuild,v 1.3 2009/11/26 11:03:54 fauli Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Robbo, a popular Atari XE/XL game ported to Linux"
HOMEPAGE="http://gnurobbo.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnurobbo/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl[audio,video,joystick]
	media-libs/sdl-ttf"

src_prepare() {
	sed -i \
		-e '/^CC=/d' \
		-e '/^CFLAGS/ { s/=/+=/; s/-O3 -pipe -Wall -fomit-frame-pointer//; }' \
		-e '/^LINK/d' \
		-e '/^LDFLAGS/d' \
		-e 's/LINK/CC/g' \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	emake \
		PACKAGE_DATA_DIR="${GAMES_DATADIR}/${PN}/" \
		BINDIR="${GAMES_BINDIR}/" \
		DOCDIR="/usr/share/doc/${PF}/" \
		|| die "emake failed"
}

src_install() {
	dogamesbin gnurobbo || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/{levels,skins,locales} || die "doins failed"
	dodoc AUTHORS Bugs ChangeLog README TODO
	newicon icon32.png ${PN}.png
	make_desktop_entry ${PN} Gnurobbo
	prepgamesdirs
}
