# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/games-kids/pytraffic/pytraffic-1.2.1.ebuild,v 1.1 2004/12/30 11:06:00 vapier Exp $

inherit games distutils

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
	epatch ${FILESDIR}/1.2-gentoo-dirs.patch
}

src_compile() {
	python_tkinter_exists
	distutils_src_compile
}

src_install() {
	DDOCS="AUTHORS.txt CHANGELOG.txt PKG-INFO"
	distutils_src_install
	dohtml DOCS/*
	prepgamesdirs
}
