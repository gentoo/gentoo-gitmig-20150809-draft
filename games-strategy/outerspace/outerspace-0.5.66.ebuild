# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/outerspace/outerspace-0.5.66.ebuild,v 1.3 2009/11/25 22:13:41 maekke Exp $

EAPI=2
inherit eutils games

MY_PN=${PN/outerspace/OuterSpace}
MY_P=${MY_PN}-${PV}
DESCRIPTION="on-line strategy game taking place in the dangerous universe"
HOMEPAGE="http://www.ospace.net/"
SRC_URI="mirror://sourceforge/ospace/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-python/pygame-1.7
	>=dev-lang/python-2.4"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		-e "s:@GENTOO_LIBDIR@:$(games_get_libdir)/${PN}:" \
		"${FILESDIR}"/${PN} > ${PN} \
		|| die "sed failed"
}

src_install() {
	insinto "$(games_get_libdir)"/${PN}
	doins -r osc.py lib libsrvr || die "doins lib failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r res || die "doins data failed"
	dogamesbin ${PN} || die "dogamesbin failed"
	newicon res/icon32.png ${PN}.png
	make_desktop_entry ${PN} ${MY_PN}
	prepgamesdirs
}
