# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xjump/xjump-2.7.5.ebuild,v 1.1 2005/03/28 21:00:13 mr_bones_ Exp $

inherit games

DEBIAN_PATCH="1.2"
DESCRIPTION="An X game where one tries to jump up as many levels as possible."
HOMEPAGE="http://packages.debian.org/stable/games/xjump"
SRC_URI="mirror://debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/x/${PN}/${PN}_${PV}-${DEBIAN_PATCH}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11"

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Where we will keep the highscore file:
	HISCORE_FILENAME=xjump.hiscores
	HISCORE_FILE="${GAMES_STATEDIR}/${HISCORE_FILENAME}"

	epatch "${WORKDIR}/${PN}_${PV}-${DEBIAN_PATCH}.diff"
	epatch  "${S}/debian/patches/"*.dpatch

	# set up where we will keep the highscores file:
	sed -i \
		-e "/^CC/d" \
		-e "/^CFLAGS/d" \
		-e "s,/var/games/xjump,${GAMES_STATEDIR}," \
		-e "s,/record,/${HISCORE_FILENAME}," \
		Makefile \
		|| die "sed failed"
}

src_install() {
	dogamesbin xjump || die "dogamesbin failed"
	dodoc README.euc

	# Set up the hiscores file:
	dodir "${GAMES_STATEDIR}"
	touch "${D}/${HISCORE_FILE}"
	fperms 660 "${HISCORE_FILE}" || die "setting permissions failed"
	prepgamesdirs
}
