# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/magnant/magnant-2.00.ebuild,v 1.2 2005/10/26 01:00:47 vapier Exp $

inherit games eutils

DESCRIPTION="Trading Card Game where cards are used in a Real Time Strategy Environment"
HOMEPAGE="http://linux.insectwar.com/"
SRC_URI="http://linux.insectwar.com/download/magnant.dev_${PV}-english.run"

LICENSE="magnant"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="games-engines/stratagus"

S=${WORKDIR}

src_unpack() {
	unpack_makeself ${A}
	tar zxf magnant.dev_${PV}.tar.gz || die "unpacking tar"
	rm -r data/doc
	chmod -R go-w doc data
	chown -R root:root doc data
}

src_install() {
	dodoc README doc/*.txt
	dohtml -r doc/*

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die

	games_make_wrapper magnant "stratagus -d '${GAMES_DATADIR}'/${PN}"
	doicon magnant.xpm
	make_desktop_entry magnant "Magnant" magnant.xpm

	prepgamesdirs
}
