# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lightyears/lightyears-1.2a.ebuild,v 1.1 2007/04/27 20:57:33 tupone Exp $

inherit eutils games

MY_PN=LightYears
MY_P=${MY_PN}-${PV}

DESCRIPTION="a single-player game with a science-fiction theme"
HOMEPAGE="http://www.jwhitham.org.uk/biscuit_games/LightYears"
SRC_URI="http://www.jwhitham.org.uk/biscuit_games/${MY_PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/pygame-1.7"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i -e "s:@GENTOO_LIBDIR@:$(games_get_libdir)/${PN}:" \
		${MY_PN}.py || die "Changing library path failed"
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		code/resource.py || die "Changing data path failed"

	mkdirhier html/data
	cp data/{006metal,header}.jpg html/data \
		|| die "Failed moving html data"
	mv data/html*.jpg html/data \
		|| die "Failed moving html data"
}

src_install() {
	dogamesbin ${MY_PN}.py  || die "dogamesbin failed"

	insinto "$(games_get_libdir)/${PN}"
	doins code/*.py || die "installing library files failed"

	dodoc README.txt
	dohtml -r *.html html/data

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/*

	newicon data/32.png ${PN}.png
	make_desktop_entry ${MY_PN}.py ${MY_PN}
	prepgamesdirs
}
