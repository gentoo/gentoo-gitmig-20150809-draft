# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/funnyboat/funnyboat-1.1.ebuild,v 1.1 2006/04/24 22:44:55 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A side scrolling shooter game starring a steamboat on the sea"
HOMEPAGE="http://funnyboat.sourceforge.net/"
SRC_URI="mirror://sourceforge/funnyboat/${P}.tar.gz"

LICENSE="GPL-2 CCPL-Attribution-2.5 CCPL-Attribution-NonCommercial-NoDerivs-2.0"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-python/pygame
	dev-python/numeric"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	cat > ${PN} <<-EOF
	#!/bin/bash
	cd "${GAMES_DATADIR}"/${PN}
	exec python main.py
	EOF
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data *.py || die "doins failed"
	dodoc README
	newicon data/merkkari.png "${PN}.png"
	make_desktop_entry "${PN}" "Trip on the Funny Boat"
	prepgamesdirs
}
