# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_statsmodels/scikits_statsmodels-0.3.1.ebuild,v 1.1 2011/09/01 05:03:08 bicatali Exp $

EAPI="2"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="${P/scikits_/scikits.}"

DESCRIPTION="Statistical computations and models for use with SciPy"
HOMEPAGE="http://statsmodels.sourceforge.net/"
SRC_URI="mirror://pypi/${PN:0:1}/scikits.statsmodels/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="sci-libs/scipy
	sci-libs/scikits"
DEPEND="dev-python/numpy
	dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? ( dev-python/nose )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# remove badly placed docs and examples
	sed -i \
		-e '/statsmodels\/docs/d' \
		-e '/statsmodels\/examples/d' \
		setup.py || die
	mv scikits/statsmodels/{docs,examples} .
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile
	if use doc; then
		"$(PYTHON -f)" setup.py build_sphinx || die "Generation of documentation failed"
	fi
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py \
			build -b "build-${PYTHON_ABI}" \
			install --home="${S}/test-${PYTHON_ABI}"
		pushd "${S}/test-${PYTHON_ABI}/lib" > /dev/null
		PYTHONPATH=. "$(PYTHON)" -c "import scikits.statsmodels; scikits.statsmodels.test()" 2>&1 | tee test.log
		grep -Eq '^(ERROR|FAIL):' test.log && return 1
		popd > /dev/null
		rm -fr test-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	remove_scikits() {
		rm -f "${ED}"$(python_get_sitedir)/scikits/__init__.py || die
	}
	python_execute_function -q remove_scikits
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/sphinx/html || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
