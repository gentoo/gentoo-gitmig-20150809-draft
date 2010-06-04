# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simplejson/simplejson-2.1.1.ebuild,v 1.7 2010/06/04 10:26:19 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A simple, fast, complete, correct and extensible JSON encoder and decoder."
HOMEPAGE="http://undefined.org/python/#simplejson http://pypi.python.org/pypi/simplejson"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc test"

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	testing() {
		ln -fs ../$(ls -d build-${PYTHON_ABI}/lib*)/simplejson/_speedups.so simplejson/_speedups.so
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
