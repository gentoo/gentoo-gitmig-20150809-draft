# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pandas/pandas-0.7.3.ebuild,v 1.4 2012/10/18 04:43:34 patrick Exp $

EAPI=4

# python cruft
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"
RESTRICT_PYTHON_ABIS="2.4  2.7-pypy-* 3.3"

inherit distutils

DESCRIPTION="Powerful data structures for data analysis and statistics"
HOMEPAGE="http://pandas.sourceforge.net/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc examples excel R"

CDEPEND="dev-python/numpy
	dev-python/python-dateutil"
DEPEND="${CDEPEND}
	doc? (
		dev-python/ipython
		dev-python/rpy
		dev-python/sphinx
		sci-libs/scikits_statsmodels
	)"
RDEPEND="${CDEPEND}
	dev-python/matplotlib
	dev-python/pytables
	dev-python/pytz
	sci-libs/scipy
	excel? (
		dev-python/openpyxl
		dev-python/xlrd
		dev-python/xlwt
	)
	R? ( dev-python/rpy )"

src_compile() {
	distutils_src_compile
	if use doc; then
		cd doc
		"$(PYTHON -f)" make.py html || die
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/build/html
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
