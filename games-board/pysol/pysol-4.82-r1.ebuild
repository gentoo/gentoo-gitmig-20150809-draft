# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol/pysol-4.82-r1.ebuild,v 1.9 2006/08/28 00:25:14 kumba Exp $

inherit eutils python games

DESCRIPTION="An exciting collection of more than 200 solitaire card games"
HOMEPAGE="http://www.pysol.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://www.pysol.org/download/pysol/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 mips ppc ppc64 x86"
IUSE=""

DEPEND="virtual/python"
RDEPEND="virtual/python
	>=games-board/pysol-sound-server-3.0
	>=dev-lang/tk-8.0"

pkg_setup() {
	python_tkinter_exists
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f Makefile data/*.pyc
	epatch "${FILESDIR}"/${P}-sound-ok.patch #94234
}

src_install() {
	insinto "${GAMES_LIBDIR}"/${PN}
	doins -r src/* || die "src failed"
	fperms 750 "${GAMES_LIBDIR}"/${PN}/pysol.py
	games_make_wrapper ${PN} "${GAMES_LIBDIR}"/${PN}/pysol.py

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "data failed"

	make_desktop_entry pysol PySol "${GAMES_DATADIR}"/${PN}/pysol.xpm

	doman pysol.6
	dodoc NEWS README

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	python_mod_optimize "${GAMES_LIBDIR}"/${PN}
}

pkg_postrm() {
	python_mod_cleanup "${GAMES_LIBDIR}"/${PN}
}
