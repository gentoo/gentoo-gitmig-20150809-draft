# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apse/apse-0.2-r1.ebuild,v 1.1 2008/05/12 07:36:30 hawking Exp $

inherit distutils
MY_PN="${PN/apse/Apse}"

DESCRIPTION="Approximate String Matching in Python."
HOMEPAGE="http://www.personal.psu.edu/staff/i/u/iua1/python/apse/"
SRC_URI="http://www.personal.psu.edu/staff/i/u/iua1/python/${PN}/dist/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-lang/swig"
RDEPEND=""

S=${WORKDIR}/${MY_PN}-${PV}

PYTHON_MODNAME="Apse"
DOCS="README* *agrep"

src_test() {
	PYTHONPATH="$(ls -d build/lib.*)" ${python} test/test_Apse.py ||\
		 die "tests failed."
}
