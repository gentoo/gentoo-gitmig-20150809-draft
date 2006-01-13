# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xjump/xjump-2.7.5.ebuild,v 1.5 2006/01/13 22:01:57 genstef Exp $

inherit eutils games

DEBIAN_PATCH="1.2"
DESCRIPTION="An X game where one tries to jump up as many levels as possible."
HOMEPAGE="http://packages.debian.org/stable/games/xjump"
SRC_URI="mirror://debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/x/${PN}/${PN}_${PV}-${DEBIAN_PATCH}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="|| (
		( x11-libs/libX11
		x11-libs/libXaw
		x11-libs/libXpm
		x11-libs/libXt
		x11-proto/xproto )
		virtual/x11
	)"

RDEPEND="|| ( 
		( x11-libs/libX11
		x11-libs/libXaw
		x11-libs/libXext
		x11-libs/libXmu
		x11-libs/libXpm
		x11-libs/libXt )
		virtual/x11
	)"


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
