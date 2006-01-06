# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/bos/bos-1.1.ebuild,v 1.3 2006/01/06 23:28:43 mr_bones_ Exp $

inherit games

MY_P=${PN}_${PV/./_}
DESCRIPTION="Invasion - Battle of Survival is a real-time strategy game using the Stratagus game engine"
HOMEPAGE="http://bos.seul.org/"
SRC_URI="http://bos.seul.org/files/${MY_P}.tar.gz
	http://dev.gentoo.org/~genstef/files/bos.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="=games-engines/stratagus-2.1*"

S=${WORKDIR}/${MY_P}

src_install() {
	dodir "${GAMES_BINDIR}"
	echo "${GAMES_BINDIR}/stratagus -d \"${GAMES_DATADIR}\"/${PN} \$*" >> "${D}${GAMES_BINDIR}/${PN}"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/* || die "doins failed"

	dodoc README.txt

	doicon "${DISTDIR}"/bos.png
	make_desktop_entry ${PN} "Invasion - Battle of Survival"
	prepgamesdirs
}
