# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/bos/bos-1.1.ebuild,v 1.1 2006/01/06 21:04:46 genstef Exp $

inherit games

MY_P=${PN}_${PV/./_}
DESCRIPTION="Invasion - Battle of Survival is a real-time strategy game using the Stratagus game engine"
HOMEPAGE="http://bos.seul.org/"
SRC_URI="http://bos.seul.org/files/${MY_P}.tar.gz
	http://dev.gentoo.org/~genstef/files/bos.png"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

RDEPEND="=games-engines/stratagus-2.1*"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_install() {
	dodir "${GAMES_BINDIR}" "${GAMES_DATADIR}/${PN}"
	echo "${GAMES_BINDIR}/stratagus -d ${GAMES_DATADIR}/${PN} \$*" >> "${D}${GAMES_BINDIR}/${PN}"
	cp -r data/* "${D}${GAMES_DATADIR}/${PN}"

	dodoc LICENSE.txt README.txt

	prepgamesdirs
	doicon ${DISTDIR}/bos.png
	make_desktop_entry ${PN} "Invasion - Battle of Survival" bos.png
}
