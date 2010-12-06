# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-0.22.0.ebuild,v 1.1 2010/12/06 20:03:58 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="*:2.5"
PYTHON_USE_WITH="tk"
PYTHON_USE_WITH_OPT="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4"

inherit distutils

DESCRIPTION="Python code static checker"
HOMEPAGE="http://www.logilab.org/projects/pylint/ http://pypi.python.org/pypi/pylint"
SRC_URI="ftp://ftp.logilab.org/pub/${PN}/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="examples tk"

# Versions specified in __pkginfo__.py.
RDEPEND=">=dev-python/logilab-common-0.53.0
	>=dev-python/astng-0.21.0"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

DOCS="doc/*.txt"

src_prepare() {
	distutils_src_prepare

	conversion() {
		[[ "${PYTHON_ABI}" == 2.* ]] && return
		find ! -path "*/test/*" -name "*.py" ! -name "setup.py" -print | xargs 2to3-${PYTHON_ABI} -nw --no-diffs
		find -path "*/test/*" -name "*.py" ! -name "setup.py" -print | xargs 2to3-${PYTHON_ABI} -nw --no-diffs

		# Ignore errors during transformation of data of tests.
		:
	}
	python_execute_function -s conversion
}

src_test() {
	testing() {
		PYTHONPATH="build/lib" pytest -v
	}
	python_execute_function -s testing
}

src_install() {
	distutils_src_install

	if ! use tk; then
		rm -f "${ED}usr/bin/pylint-gui"*
	fi

	doman man/{pylint,pyreverse}.1 || die "doman failed"

	if use examples; then
		docinto examples
		dodoc examples/* || die "dodoc failed"
	fi

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/pylint/test"
	}
	python_execute_function -q delete_tests
}
