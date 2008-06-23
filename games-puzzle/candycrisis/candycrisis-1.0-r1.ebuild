# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/candycrisis/candycrisis-1.0-r1.ebuild,v 1.2 2008/06/23 07:30:21 opfer Exp $

inherit eutils games

DESCRIPTION="An exciting combination of pure action and puzzle gaming"
HOMEPAGE="http://candycrisis.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="=media-libs/fmod-3*
	media-libs/libsdl
	media-libs/sdl-image"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/CandyCrisis/Source

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}/:g" \
		main.cpp \
		|| die "sed failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins ../CandyCrisisResources/* || die "doins failed"
	newicon ../CandyCrisisResources/PICT_10000.png ${PN}.png
	make_desktop_entry ${PN} CandyCrisis
	dodoc ../CandyCrisisReadMe.rtf
	prepgamesdirs
}
