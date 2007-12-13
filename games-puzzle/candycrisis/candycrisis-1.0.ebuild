# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/candycrisis/candycrisis-1.0.ebuild,v 1.2 2007/12/13 00:06:02 tupone Exp $

inherit eutils games

DESCRIPTION="An exciting combination of pure action and puzzle gaming"
HOMEPAGE="http://candycrisis.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="=media-libs/fmod-3*
	media-libs/sdl-image"

S=${WORKDIR}/CandyCrisis/Source

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}/:g" \
		-e "s:@GENTOO_STATEDIR@:${GAMES_STATEDIR}/${PN}/:g" \
		main.cpp prefs.cpp || die "sed failed"
	mv ../CandyCrisisResources/Preferences.txt . \
		|| die "Move of preference file failed"
}

src_install() {
	dogamesbin CandyCrisis || die "dogamesbin failed"
	dodoc ../CandyCrisisReadMe.rtf
	insinto "${GAMES_DATADIR}"/${PN}
	doins ../CandyCrisisResources/* || die "Installing data failed"
	if [ ! -e "${GAMES_STATEDIR}"/${PN}/Preferences.txt ]; then
		insinto "${GAMES_STATEDIR}"/${PN}
		insopts -m0760
		doins Preferences.txt || die "Installing preference file failed"
	fi
	newicon ../CandyCrisisResources/PICT_10000.png ${PN}.png
	make_desktop_entry "CandyCrisis" "CandyCrisis" ${PN}.png
	prepgamesdirs
}
