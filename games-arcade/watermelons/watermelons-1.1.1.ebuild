# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/watermelons/watermelons-1.1.1.ebuild,v 1.1 2006/04/18 07:36:35 mr_bones_ Exp $

inherit eutils games

MY_PN="melons"
DESCRIPTION="A thrilling watermelon bouncing game."
HOMEPAGE="http://www.imitationpickles.org/melons/index.html"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tgz"
# No version upstream
#SRC_URI="http://www.imitationpickles.org/${MY_PN}/${MY_PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.4"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:melons.hs:${GAMES_STATEDIR}/${PN}/&:" \
		main.py \
		|| die "sed failed"

	cat <<-EOF > "${PN}"
	#!/bin/bash
	cd "${GAMES_DATADIR}/${PN}"
	exec python main.py
EOF
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data pgu const.py game.py main.py melon.py melons.py menu.py trampoline.py \
		|| die "doins failed"
	dodoc *.txt
	dodir "${GAMES_STATEDIR}/${PN}"
	touch "${D}${GAMES_STATEDIR}"/${PN}/melons.hs
	fperms 664 "${GAMES_STATEDIR}"/${PN}/melons.hs
	newicon data/mellon0013.png "${PN}.png" || die "newicon failed"
	make_desktop_entry ${PN} Watermelons
	prepgamesdirs
}
