# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mimeparse/mimeparse-0.1.3.ebuild,v 1.1 2012/04/25 19:39:10 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Basic functions for handling mime-types in python"
HOMEPAGE="http://code.google.com/p/mimeparse"
SRC_URI="http://mimeparse.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
PYTHON_MODNAME="mimeparse.py"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/simplejson )"

# tests fail for python3
src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib/" \
		"$(PYTHON)" mimeparse_test.py
	}
	python_execute_function testing
}
