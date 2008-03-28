# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lightyears/lightyears-1.2a.ebuild,v 1.5 2008/03/28 12:22:42 nyhm Exp $

inherit eutils python games

MY_PN=LightYears
MY_P=${MY_PN}-${PV}
DESCRIPTION="a single-player game with a science-fiction theme"
HOMEPAGE="http://www.jwhitham.org.uk/biscuit_games/LightYears/"
SRC_URI="http://www.jwhitham.org.uk/biscuit_games/${MY_PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/pygame-1.7"
DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i -e "s:@GENTOO_LIBDIR@:$(games_get_libdir)/${PN}:" \
		${MY_PN}.py || die "Changing library path failed"
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		code/resource.py || die "Changing data path failed"

	mkdir -p html/data
	cp data/{006metal,header}.jpg html/data \
		|| die "Failed moving html data"
	mv data/html*.jpg html/data \
		|| die "Failed moving html data"
}

src_install() {
	newgamesbin ${MY_PN}.py ${PN} || die "newgamesbin failed"

	insinto "$(games_get_libdir)/${PN}"
	doins code/*.py || die "doins code failed"

	dodoc README.txt
	dohtml -r *.html html/data

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/* || die "doins data failed"

	newicon data/32.png ${PN}.png
	make_desktop_entry ${PN} "Light Years Into Space"
	prepgamesdirs
}

pkg_postinst() {
	python_mod_optimize "${ROOT}$(games_get_libdir)/${PN}"
	games_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup "$(games_get_libdir)/${PN}"
}
