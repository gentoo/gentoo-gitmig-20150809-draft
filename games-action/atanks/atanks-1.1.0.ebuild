# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/atanks/atanks-1.1.0.ebuild,v 1.7 2004/10/31 21:53:36 josejx Exp $

inherit eutils gcc games

DATA_DIR="${GAMES_DATADIR}/${PN}"
DESCRIPTION="Worms and Scorched Earth-like game"
HOMEPAGE="http://atanks.sourceforge.net/"
SRC_URI="mirror://sourceforge/atanks/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/x11
	>=media-libs/allegro-4.0.3
	>=media-libs/allegttf-2.0"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#apply both patches to compile with gcc-3.4.0 closing bug #49457
	if [ "$(gcc-major-version)" -ge "3" -a "$(gcc-minor-version)" -ge "4" ]
	then
		epatch "${FILESDIR}/atanks-gcc34.patch"
	fi

	sed -i \
		-e "s:DATA_DIR=.*:DATA_DIR=\\\\\"${DATA_DIR}\\\\\":" \
		src/Makefile \
		|| die "sed src/Makefile failed"
}

src_install() {
	dogamesbin atanks || die "dogamesbin failed"
	dodir "${DATA_DIR}"
	cp {credits,gloat,instr,revenge}.txt *dat "${D}${DATA_DIR}" \
		|| die "cp failed"
	dodoc BUGS Changelog Help.txt tanks.txt README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "NOTE: If you had atanks version 0.9.8b or less installed"
	einfo "remove ~/.atanks-config to take advantage of new features."
}
