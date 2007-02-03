# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/bos/bos-2.0.1.ebuild,v 1.3 2007/02/03 15:52:10 nixnut Exp $

inherit eutils versionator games

MY_P=${PN}_$(replace_all_version_separators '_')
DESCRIPTION="Invasion - Battle of Survival is a real-time strategy game using the Stratagus game engine"
HOMEPAGE="http://bos.seul.org/"
SRC_URI="http://bos.seul.org/files/${MY_P}.tar.gz
	mirror://gentoo/bos.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=games-engines/stratagus-2.2.1"

S=${WORKDIR}/data.bos

src_install() {
	games_make_wrapper ${PN} "stratagus -d ${GAMES_DATADIR}/${PN}"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r $(find . -mindepth 1 -maxdepth 1 -type d) || die "doins failed"
	dodoc CHANGELOG README.txt
	doicon "${DISTDIR}"/bos.png
	make_desktop_entry ${PN} "Invasion - Battle of Survival"
	prepgamesdirs
}
