# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/galaxyhack/galaxyhack-1.69.ebuild,v 1.1 2006/10/30 20:01:32 tupone Exp $

inherit eutils games

DESCRIPTION="Multiplayer AI script based strategy game."
HOMEPAGE="http://galaxyhack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2 galaxyhack"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	dev-libs/boost"

S="${WORKDIR}/${PN}/src"

src_unpack() {
	unpack ${A}
	cd "${S}"
	edos2unix Makefile
	epatch "${FILESDIR}"/${P}-destdirs.patch
	sed -i -e "s:@GAMES_DATADIR@:${GAMES_DATADIR}:"	\
		Main.cpp
	sed -i -e "/Base data path/s:pwd:${GAMES_DATADIR}/${PN}:"	\
		../settings.dat
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"
	cd ..
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r fleets gamedata graphics music standardpictures \
		settings.dat || die "doins failed"
	dodoc readme.txt || die "dodoc failed"
	doicon "${FILESDIR}/${PN}.png" || die "doicon failed"
	make_desktop_entry "${PN}" GalaxyHack "${PN}.png"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Settings will default to those found in ${GAMES_DATADIR}/galaxyhack/settings.dat."
	einfo "Per user settings can be specified by creating \$HOME/.galaxyhack/settings.dat"
	einfo "Additional user submitted fleets can be downloaded from http://galaxyhack.sourceforge.net/viewfleets.php"
}
