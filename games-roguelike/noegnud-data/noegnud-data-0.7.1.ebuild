# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/noegnud-data/noegnud-data-0.7.1.ebuild,v 1.1 2003/09/10 04:59:58 vapier Exp $ 

inherit games eutils

BASE_PV=0.7.0
DESCRIPTION="ultimate User Interface for nethack"
HOMEPAGE="http://noegnud.sourceforge.net/"
SRC_URI="mirror://sourceforge/noegnud/noegnud-${BASE_PV}-src.tar.gz
	mirror://sourceforge/noegnud/noegnud-${BASE_PV}-noegnud-${PV}.diff"

LICENSE="nethack"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/noegnud-${BASE_PV}/noegnud_data

src_unpack() {
	unpack noegnud-${BASE_PV}-src.tar.gz
	epatch ${DISTDIR}/noegnud-${BASE_PV}-noegnud-${PV}.diff
}

src_install() {
	dodir ${GAMES_DATADIR}/noegnud_data
	dodoc README THANKS news
	rm README THANKS news
	cp -fr * ${D}/${GAMES_DATADIR}/noegnud_data/
	prepgamesdirs
}
