# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/BitVector/BitVector-3.0.ebuild,v 1.1 2011/07/29 21:23:13 bicatali Exp $

EAPI=3
PYTHON_DEPEND=2
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils

DESCRIPTION="A pure-Python memory-efficient packed representation for bit arrays"
HOMEPAGE="http://rvl4.ecn.purdue.edu/~kak/dist/${P}.html"
SRC_URI="http://rvl4.ecn.purdue.edu/~kak/dist/${P}.tar.gz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_test() {
	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" Test.py
	}
	pushd Test${PN} > /dev/null
	python_execute_function testing
	popd > /dev/null
}
