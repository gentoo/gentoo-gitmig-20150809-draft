# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/games-kids/pytraffic/pytraffic-1.2.1.ebuild,v 1.2 2004/12/31 06:13:07 vapier Exp $

inherit distutils games

DESCRIPTION="Python version of the board game Rush Hour"
HOMEPAGE="http://alpha.luc.ac.be/Research/Algebra/Members/pytraffic"
SRC_URI="http://alpha.luc.ac.be/Research/Algebra/Members/pytraffic/PyTraffic-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
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

pkg_postinst() {
	if has_version ">=dev-lang/python-2.3"; then
		python_version
		python_mod_optimize ${ROOT}usr/share/games/${PN}12
	fi
	games_pkg_postinst
}
