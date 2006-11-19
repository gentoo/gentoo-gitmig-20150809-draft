# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/kcheckers/kcheckers-0.8.1.ebuild,v 1.2 2006/11/19 12:02:31 nyhm Exp $

inherit eutils toolchain-funcs qt4 games

DESCRIPTION="Qt version of the classic boardgame checkers"
HOMEPAGE="http://kcheckers.wibix.de/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="$(qt4_min_version 4.1)"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i "s:/usr/local:${GAMES_DATADIR}:" \
		common.h || die "sed common.h failed"

	sed -i "s:PREFIX\"/share:\"${GAMES_DATADIR}:" \
		main.cc toplevel.cc || die "sed failed"

	echo "QMAKE_CXXFLAGS_RELEASE = ${CXXFLAGS}" >> kcheckers.pro
	echo "QMAKE_LFLAGS_RELEASE = ${LDFLAGS}" >> kcheckers.pro
}

src_compile() {
	qmake || die "qmake failed"
	emake \
		CXX=$(tc-getCXX) \
		LINK=$(tc-getCXX) \
		|| die "emake failed"
}

src_install() {
	dogamesbin kcheckers || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r i18n/* themes || die "doins failed"

	newicon icons/biglogo.png ${PN}.png
	make_desktop_entry ${PN} KCheckers

	dodoc AUTHORS ChangeLog FAQ README TODO
	prepgamesdirs
}
