# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_statsmodels/scikits_statsmodels-0.4.0.ebuild,v 1.3 2012/06/21 18:57:34 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"
VIRTUALX_REQUIRED=test
RESTRICT_PYTHON_ABIS="2.4 2.7-pypy-*"
inherit distutils virtualx

MYPN="${PN/scikits_/}"
MYP="${MYPN}-${PV}"

DESCRIPTION="Statistical computations and models for use with SciPy"
HOMEPAGE="http://statsmodels.sourceforge.net/"
SRC_URI="mirror://pypi/${MYPN:0:1}/${MYPN}/${MYP}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/pandas
	sci-libs/scikits
	sci-libs/scipy
	examples? ( dev-python/matplotlib )"
DEPEND=">=dev-python/cython-0.15.1
	dev-python/pandas
	sci-libs/scipy
	dev-python/setuptools
	doc? ( dev-python/sphinx >=dev-python/ipython-0.12 )
	test? ( dev-python/nose )"

S="${WORKDIR}/${MYP}"

src_compile() {
	distutils_src_compile
	if use doc; then
		"$(PYTHON -f)" setup.py build_sphinx || die
	fi
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	remove_scikits() {
		rm -f "${ED}"$(python_get_sitedir)/scikits/__init__.py || die
	}
	python_execute_function -q remove_scikits
	use doc && dohtml -r build/sphinx/html
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
