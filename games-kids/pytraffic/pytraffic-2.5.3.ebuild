# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/pytraffic/pytraffic-2.5.3.ebuild,v 1.1 2006/10/13 16:16:47 nyhm Exp $

inherit distutils eutils games

DESCRIPTION="Python version of the board game Rush Hour"
HOMEPAGE="http://alpha.uhasselt.be/Research/Algebra/Members/pytraffic/"
SRC_URI="http://alpha.uhasselt.be/Research/Algebra/Members/pytraffic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-python/pygame
	>=dev-python/pygtk-2.4"

src_compile() {
	distutils_src_compile
}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r doc extra_themes icons libglade music sound_test themes \
		*.py ttraffic.levels || die "doins failed"

	exeinto "${GAMES_LIBDIR}"/${PN}
	doexe build/*/_hint.so || die "doexe failed"
	dosym {"${GAMES_LIBDIR}","${GAMES_DATADIR}"}/${PN}/_hint.so \
		|| die "dosym failed"

	games_make_wrapper ${PN} "python Main.py" "${GAMES_DATADIR}"/${PN}
	newicon icons/carNred64x64.png ${PN}.png
	make_desktop_entry ${PN} PyTraffic

	dodoc AUTHORS CHANGELOG README

	rm "${GAMES_DATADIR}"/${PN}/setup.py
	prepgamesdirs
}

pkg_postinst() {
	distutils_pkg_postinst
	games_pkg_postinst
}
