# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-0.21.3.ebuild,v 1.3 2010/10/23 14:06:15 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"
PYTHON_USE_WITH_OPT="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python code static checker"
HOMEPAGE="http://www.logilab.org/projects/pylint/ http://pypi.python.org/pypi/pylint"
SRC_URI="ftp://ftp.logilab.org/pub/${PN}/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="examples tk"

# Versions specified in __pkginfo__.py.
RDEPEND=">=dev-python/logilab-common-0.50.1
	>=dev-python/astng-0.20.1"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="doc/*.txt"

src_test() {
	if has_version "<dev-python/logilab-common-0.52.0"; then
		ewarn "Skipping tests due to old version of dev-python/logilab-common"
		return
	fi

	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" pytest -v
	}
	python_execute_function testing
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
}
