# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-modsetup/halflife-modsetup-0.1.1.ebuild,v 1.2 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games

DESCRIPTION="script to assist in setting up your server"
HOMEPAGE="http://wh0rd.org/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"

RDEPEND="dev-util/dialog"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "s:GENTOO_HLDIR:${GAMES_PREFIX_OPT}/halflife:" \
		-e "s:GENTOO_CFGDIR:${GAMES_SYSCONFDIR}/halflife:" \
		${S}/halflife-modsetup
}

src_install() {
	dogamesbin halflife-modsetup
	insinto ${GAMES_SYSCONFDIR}/halflife
	doins modsetup.conf
	prepgamesdirs
}
