# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/piddle/piddle-1.0.15.ebuild,v 1.4 2004/07/22 16:52:05 pythonhead Exp $

DESCRIPTION="Cross-media, cross-platform 2D graphics package"
HOMEPAGE="http://piddle.sourceforge.net/"
SRC_URI="mirror://sourceforge/piddle/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=dev-lang/python-1.5.2"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc README.txt
	dohtml -r docs/*
}
