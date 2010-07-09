# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/decorator/decorator-3.2.0.ebuild,v 1.4 2010/07/09 13:27:59 fauli Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Simplifies the usage of decorators for the average programmer"
HOMEPAGE="http://pypi.python.org/pypi/decorator"
SRC_URI="http://pypi.python.org/packages/source/d/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE="doc"

DEPEND="dev-python/setuptools"
RDEPEND=""

DOCS="README.txt"
PYTHON_MODNAME="decorator.py"

src_test() {
	testing() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" documentation3.py
		else
			PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" documentation.py
		fi
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
	   dodoc documentation.pdf documentation3.pdf || die "dodoc failed"
	   dohtml documentation.html documentation3.html || die "dohtml failed"
	fi
}
