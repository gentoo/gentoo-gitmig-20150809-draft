# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/atanks/atanks-2.5.ebuild,v 1.1 2007/08/18 01:17:44 mr_bones_ Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Worms and Scorched Earth-like game"
HOMEPAGE="http://atanks.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/allegro"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CC/s:g++:$(tc-getCXX):" \
		-e '/^CFLAGS/s:-g::' \
		-e 's:CFLAGS:CXXFLAGS:' \
		-e '/^LDFLAGS/s:=:+=:' \
		-e "s:DATA_DIR=.*:DATA_DIR=\\\\\"${GAMES_DATADIR}/${PN}\\\\\":" \
		src/Makefile \
		|| die "sed failed"
	emake clean
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins *.dat *.txt || die "doins failed"
	dodoc BUGS Changelog README TODO
	prepgamesdirs
}
