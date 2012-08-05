# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/pyephem/pyephem-3.7.5.1.ebuild,v 1.3 2012/08/05 19:18:28 bicatali Exp $

EAPI=4
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython 2.7-pypy-*"

inherit distutils eutils

DESCRIPTION="Astronomical routines for the python programming language"
LICENSE="LGPL-3"
HOMEPAGE="http://rhodesmill.org/pyephem/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"
RDEPEND=""
DEPEND="doc? ( dev-python/sphinx )"

src_prepare() {
	# don't install rst files
	sed -i -e "s:'doc/\*\.rst',::" setup.py || die
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile
	if use doc; then
		cd src/ephem/doc
		PYTHONPATH=../../.. emake html
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml -r src/ephem/doc/.build/html/*
}
