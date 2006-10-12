# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/qlife/qlife-0.9.ebuild,v 1.1 2006/10/12 19:24:34 nyhm Exp $

inherit toolchain-funcs qt4 games

MY_P=${PN}-qt4-${PV}
DESCRIPTION="Simulates the classical Game of Life invented by John Conway"
HOMEPAGE="http://personal.inet.fi/koti/rkauppila/projects/life/"
SRC_URI="http://personal.inet.fi/koti/rkauppila/projects/life/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="$(qt4_min_version 4.1)"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "/setPath/s:patterns:${GAMES_DATADIR}/${PN}/patterns:" \
		lifedialog.cpp || die "sed failed"
}

src_compile() {
	qmake || die "qmake failed"
	emake \
		CXX=$(tc-getCXX) \
		LINK=$(tc-getCXX) \
		|| die "emake failed"
}

src_install() {
	dogamesbin qlife || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins patterns/* || die "doins failed"
	dohtml *.html
	dodoc About README
	prepgamesdirs
}
