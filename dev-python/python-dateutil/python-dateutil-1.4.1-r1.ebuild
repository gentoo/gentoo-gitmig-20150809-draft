# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-dateutil/python-dateutil-1.4.1-r1.ebuild,v 1.4 2009/12/24 17:35:10 pacho Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="dateutil datetime math and logic library for python"
HOMEPAGE="http://labix.org/python-dateutil http://pypi.python.org/pypi/python-dateutil"
SRC_URI="http://labix.org/download/python-dateutil/${P}.tar.gz"

LICENSE="PSF-2.3"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DOCS="NEWS README"

DEPEND=">=dev-python/setuptools-0.6_rc7-r1"
RDEPEND="sys-libs/timezone-data"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="dateutil"

src_prepare() {
	epatch "${FILESDIR}"/${P}-locale.patch
	# use zoneinfo in /usr/share/zoneinfo
	sed -i -e 's/zoneinfo.gettz/gettz/g' test.py || die
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test.py
	}
	python_execute_function testing
}

src_install() {
	[[ -z "${ED}" ]] && local ED="${D}"
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins example.py sandbox/*.py
	rm -f "${ED}"/usr/lib*/python*/site-packages/dateutil/zoneinfo/*.tar.*
}
