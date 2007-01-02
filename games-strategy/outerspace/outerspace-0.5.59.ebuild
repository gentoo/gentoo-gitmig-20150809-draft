# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/outerspace/outerspace-0.5.59.ebuild,v 1.2 2007/01/02 00:45:05 tupone Exp $

inherit eutils games

MY_PN=${PN/outerspace/OuterSpace}
MY_P=${MY_PN}-$PV

DESCRIPTION="on-line strategy game taking place in the dangerous universe"
HOMEPAGE="http://www.ospace.net"
SRC_URI="mirror://sourceforge/ospace/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-python/pygame-1.7
	>=dev-lang/python-2.4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp ${FILESDIR}/${PN} . || die "cp of wrapper failed"
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		-e "s:@GENTOO_LIBDIR@:${GAMES_LIBDIR}/${PN}:" \
		${PN} || die "sed, updating path, failed"
}

src_install() {
	insinto ${GAMES_LIBDIR}/${PN}
	doins -r osc.py lib libsrvr || die "doins of libraries failed"
	insinto ${GAMES_DATADIR}/${PN}
	doins -r res || die "doins of data failed"
	dogamesbin ${PN} || die "dogamesbin failed"

	newicon res/icon32.png ${PN}.png

	make_desktop_entry ${PN} ${MY_PN} ${PN}.png
	prepgamesdirs
}
