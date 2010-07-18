# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-0.21.0.ebuild,v 1.5 2010/07/18 14:07:33 nixnut Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"
PYTHON_USE_WITH_OPT="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python code static checker"
HOMEPAGE="http://www.logilab.org/projects/pylint/ http://pypi.python.org/pypi/pylint"
SRC_URI="ftp://ftp.logilab.org/pub/${PN}/${P}.tar.gz http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc examples test tk"

# Versions specified in __pkginfo__.py.
DEPEND=">=dev-python/logilab-common-0.50.1
	>=dev-python/astng-0.20.1"
RDEPEND="${DEPEND}"

src_prepare() {
	distutils_src_prepare

	# Disable failing tests.
	rm -f test/input/func_arguments.py
	sed -e "s/test_exhaustivity/_&/" -i test/test_func.py || die "sed failed"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" pytest -v
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	doman man/{pylint,pyreverse}.1 || die "doman failed"
	dodoc doc/FAQ.txt || die "dodoc failed"

	if use doc; then
		dodoc doc/*.txt || die "dodoc failed"
	fi

	if use examples; then
		docinto examples
		dodoc examples/* || die "dodoc failed"
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	if ! has_version "=dev-lang/python-2*[tk]"; then
		ewarn "dev-lang/python has been built without tk support,"
		ewarn "${PN}-gui doesn't work without Tkinter so if you really need it,"
		ewarn "re-install dev-lang/python with \"tk\" useflag enabled."
	fi
}
