# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol/pysol-4.82-r2.ebuild,v 1.1 2007/04/02 19:30:24 tupone Exp $

inherit eutils python games

PNX=pysol-cardsets
PVX=4.40

DESCRIPTION="An exciting collection of more than 200 solitaire card games"
HOMEPAGE="http://www.pysol.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://www.pysol.org/download/pysol/${P}-src.tar.bz2
	extra-cardsets? (
		http://ftp.debian.org/debian/pool/main/p/${PNX}/${PNX}_${PVX}.orig.tar.gz
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 mips ppc ppc64 x86"
IUSE="extra-cardsets"

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
	if use extra-cardsets; then
		mv ../${PNX}-${PVX}/README{,.extra}
		mv ../${PNX}-${PVX}/NEWS{,.extra}
		# Removing cardsets already shipped with pysol tar
		for cardset in cardset-2000 cardset-colossus cardset-hard-a-port \
			cardset-hexadeck cardset-kintengu cardset-oxymoron \
			cardset-tuxedo cardset-vienna-2k ; do
			rm -rf ../${PNX}-${PVX}/data/$cardset
		done
	fi
}

src_install() {
	insinto "${GAMES_LIBDIR}"/${PN}
	doins -r src/* || die "src failed"
	fperms 750 "${GAMES_LIBDIR}"/${PN}/pysol.py
	games_make_wrapper ${PN} "${GAMES_LIBDIR}"/${PN}/pysol.py

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "data failed"

	doicon data/pysol.xpm
	make_desktop_entry pysol PySol pysol.xpm 'Game;CardGame'

	doman pysol.6
	dodoc NEWS README

	if use extra-cardsets; then
		doins -r ../${PNX}-${PVX}/data/* || die "Installing extra cardsets failed"
		dodoc ../${PNX}-${PVX}/{NEWS,README}.extra \
			|| die "Extra cardsets doc installation failed"
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	python_mod_optimize "${GAMES_LIBDIR}"/${PN}
}

pkg_postrm() {
	python_mod_cleanup "${GAMES_LIBDIR}"/${PN}
}
