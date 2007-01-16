# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/bos/bos-2.0.1.ebuild,v 1.1 2007/01/16 09:29:07 tchiwam Exp $

inherit eutils games versionator

MY_PV=$(replace_all_version_separators '_')
MY_P=${PN}_${MY_PV}
DESCRIPTION="Invasion - Battle of Survival is a real-time strategy game using the Stratagus game engine"
HOMEPAGE="http://bos.seul.org/"
SRC_URI="http://bos.seul.org/files/${MY_P}.tar.gz
	http://dev.gentoo.org/~genstef/files/bos.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=games-engines/stratagus-2.2.1"

S=${WORKDIR}/${MY_P}

src_install() {
	dodir "${GAMES_BINDIR}"
	echo "${GAMES_BINDIR}/stratagus -d \"${GAMES_DATADIR}/${PN}/data.bos\" \$*" >> "${D}${GAMES_BINDIR}/${PN}"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r ${WORKDIR}/data.bos || die "doins failed"

#	dodoc README.txt

	doicon "${DISTDIR}"/bos.png
	make_desktop_entry ${PN} "Invasion - Battle of Survival"
	prepgamesdirs
}
