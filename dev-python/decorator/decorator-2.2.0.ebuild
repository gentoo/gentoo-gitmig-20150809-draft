# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/decorator/decorator-2.2.0.ebuild,v 1.2 2008/05/02 16:54:34 mr_bones_ Exp $

inherit distutils

DESCRIPTION="Simplifies the usage of decorators for the average programmer"
HOMEPAGE="http://www.phyast.pitt.edu/~micheles/python/documentation.html"
SRC_URI="http://www.phyast.pitt.edu/~micheles/python/${P}.zip"
LICENSE="BSD"
KEYWORDS="~x86"
SLOT="0"
IUSE="doc"
S="${WORKDIR}"
DEPEND="app-arch/unzip"
DOCS="CHANGES.txt documentation.txt documentation.pdf"

src_install() {
	distutils_src_install
	use doc && dohtml documentation.html
}

src_test() {
	PYTHONPATH=. "${python}" doctester.py documentation.txt || die "tests failed"
}
