# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol/pysol-4.82-r2.ebuild,v 1.10 2009/01/29 02:06:43 mr_bones_ Exp $

EAPI=2
inherit eutils python games

PNX=pysol-cardsets
PVX=4.40
DESCRIPTION="An exciting collection of more than 200 solitaire card games"
HOMEPAGE="http://www.pysol.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://www.pysol.org/download/pysol/${P}-src.tar.bz2
	extra-cardsets? (
		mirror://debian/pool/main/p/${PNX}/${PNX}_${PVX}.orig.tar.gz
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 sparc x86"
IUSE="extra-cardsets"

DEPEND="dev-lang/python[tk]"
RDEPEND="dev-lang/python[tk]
	>=games-board/pysol-sound-server-3.0
	>=dev-lang/tk-8.0"

src_prepare() {
	rm -f Makefile data/*.pyc
	epatch "${FILESDIR}"/${P}-sound-ok.patch #94234
	if use extra-cardsets; then
		mv ../${PNX}-${PVX}/README{,.extra}
		mv ../${PNX}-${PVX}/NEWS{,.extra}
		# Removing cardsets already shipped with pysol tar
		local cardset
		for cardset in cardset-2000 cardset-colossus cardset-hard-a-port \
			cardset-hexadeck cardset-kintengu cardset-oxymoron \
			cardset-tuxedo cardset-vienna-2k ; do
			rm -rf ../${PNX}-${PVX}/data/${cardset}
		done
	fi
}

src_install() {
	insinto "$(games_get_libdir)"/${PN}
	doins -r src/* || die "src failed"
	games_make_wrapper ${PN} "python ./pysol.py" "$(games_get_libdir)"/${PN}

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "data failed"

	doicon data/pysol.xpm
	make_desktop_entry pysol PySol pysol 'Game;CardGame'

	doman pysol.6
	dodoc NEWS README

	if use extra-cardsets; then
		doins -r ../${PNX}-${PVX}/data/* || die "Installing extra cardsets failed"
		dodoc ../${PNX}-${PVX}/{NEWS,README}.extra
	fi

	prepgamesdirs
}

pkg_postinst() {
	python_mod_optimize "$(games_get_libdir)"/${PN}
	games_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup "$(games_get_libdir)"/${PN}
}
