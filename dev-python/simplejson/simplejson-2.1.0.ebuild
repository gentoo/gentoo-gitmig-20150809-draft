# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simplejson/simplejson-2.1.0.ebuild,v 1.1 2010/03/11 16:17:58 djc Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"

DESCRIPTION="A simple, fast, complete, correct and extensible JSON encoder and decoder."
HOMEPAGE="http://undefined.org/python/#simplejson"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
IUSE="doc test"

DEPEND="dev-python/setuptools"
RDEPEND=""

RESTRICT_PYTHON_ABIS="3*"

# failures reported as http://code.google.com/p/simplejson/issues/detail?id=73
src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" simplejson/tests/__init__.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/*
	fi
}
