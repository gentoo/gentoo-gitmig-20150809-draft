# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/noegnud-data/noegnud-data-0.8.0.ebuild,v 1.4 2004/03/21 18:15:07 jhuebel Exp $ 

inherit games eutils

# for more info on these themes visit:
# http://noegnud.sourceforge.net/downloads.shtml

# absurd itakura mazko abigabi geoduck lagged aoki falconseye
GUI_THEME=absurd
# falconseye nhs
SND_THEME=falconseye
DESCRIPTION="ultimate User Interface for nethack"
HOMEPAGE="http://noegnud.sourceforge.net/"
SRC_URI="mirror://sourceforge/noegnud/noegnud-${PV}_data-tileset-${GUI_THEME}.tar.bz2
	mirror://sourceforge/noegnud/noegnud-${PV}_data-sound-${SND_THEME}.tar.bz2"

LICENSE="nethack"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

S=${WORKDIR}/noegnud-${PV}/data

src_install() {
	dodir ${GAMES_DATADIR}/noegnud_data
	cp -r * ${D}/${GAMES_DATADIR}/noegnud_data/
	prepgamesdirs
}
