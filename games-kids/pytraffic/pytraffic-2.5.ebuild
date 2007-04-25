# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/pytraffic/pytraffic-2.5.ebuild,v 1.4 2007/04/25 21:03:41 nyhm Exp $

inherit distutils eutils games

DESCRIPTION="Python version of the board game Rush Hour"
HOMEPAGE="http://alpha.uhasselt.be/Research/Algebra/Members/pytraffic/"
SRC_URI="http://alpha.uhasselt.be/Research/Algebra/Members/pytraffic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="dev-python/pygame
	>=dev-python/pygtk-2.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gentoo-dirs.patch"
}

src_compile() {
	distutils_src_compile
}

src_install() {
	DOCS="AUTHORS.txt CHANGELOG.txt PKG-INFO"
	distutils_src_install
	dohtml DOCS/*
	prepgamesdirs
}

pkg_postinst() {
	distutils_pkg_postinst
	games_pkg_postinst
}
