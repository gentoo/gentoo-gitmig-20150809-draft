# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/battalion/battalion-1.4b.ebuild,v 1.8 2004/11/02 20:54:47 josejx Exp $

inherit games

DESCRIPTION="Be a rampaging monster and destroy the city."
HOMEPAGE="http://evlweb.eecs.uic.edu/aej/AndyBattalion.html"
SRC_URI="http://evlweb.eecs.uic.edu/aej/BATTALION/${PN}${PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""

RDEPEND="virtual/x11
	virtual/opengl"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${PN}${PV}"
dir="${GAMES_DATADIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Modify data paths
	sed -i \
		-e "s:SOUNDS/:${dir}/SOUNDS/:" \
		-e "s:MUSIC/:${dir}/MUSIC/:" \
		audio.c || die "sed audio.c failed"
	sed -i \
		-e "s:DATA/:${dir}/DATA/:" \
		-e "s:/usr/tmp:${GAMES_STATEDIR}:" \
		battalion.c || die "sed battalion.c failed"
	sed -i \
		-e "s:TEXTURES/:${dir}/TEXTURES/:" \
		graphics.c || die "sed graphics.c failed"

	# Modify Makefile and add CFLAGS
	sed -i \
		-e "s:-O2:${CFLAGS}:" \
		Makefile || die "sed Makefile failed"
	# Only .raw sound files are used on Linux. The .au files are not needed.
	rm {SOUNDS,MUSIC}/*.au
}

src_install() {
	dogamesbin battalion || die "dogamesbin failed"
	dodir "${dir}"
	cp -r DATA MUSIC SOUNDS TEXTURES "${D}${dir}" || die "cp failed"
	dodoc README

	dodir "${GAMES_STATEDIR}"
	touch "${D}${GAMES_STATEDIR}/battalion_hiscore"
	fperms 660 "${GAMES_STATEDIR}/battalion_hiscore"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Sound and music are not enabled by default."
	einfo "Use the S and M keys to enable them in-game, or start the game with"
	einfo "the -s and -m switches: battalion -s -m"
}
