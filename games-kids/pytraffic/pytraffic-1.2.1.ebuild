# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/pytraffic/pytraffic-1.2.1.ebuild,v 1.6 2005/02/22 12:12:55 dholm Exp $

inherit distutils eutils games

DESCRIPTION="Python version of the board game Rush Hour"
HOMEPAGE="http://alpha.luc.ac.be/Research/Algebra/Members/pytraffic"
SRC_URI="http://alpha.luc.ac.be/Research/Algebra/Members/pytraffic/PyTraffic-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc"
IUSE=""

DEPEND="dev-lang/python
	dev-lang/tk
	dev-python/pygame"

S="${WORKDIR}/PyTraffic-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-dirs.patch
}

src_compile() {
	python_tkinter_exists
	distutils_src_compile
}

src_install() {
	DOCS="AUTHORS.txt CHANGELOG.txt PKG-INFO"
	distutils_src_install
	dohtml DOCS/*
	prepgamesdirs
}

pkg_postrm() {
	distutils_pkg_postrm
}

pkg_postinst() {
	distutils_pkg_postinst
	games_pkg_postinst
}
