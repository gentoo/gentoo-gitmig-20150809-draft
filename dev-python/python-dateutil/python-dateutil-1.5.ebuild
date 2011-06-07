# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-dateutil/python-dateutil-1.5.ebuild,v 1.6 2011/06/07 11:22:55 naota Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="dateutil datetime math and logic library for python"
HOMEPAGE="http://labix.org/python-dateutil http://pypi.python.org/pypi/python-dateutil"
SRC_URI="http://labix.org/download/python-dateutil/${P}.tar.gz"

LICENSE="PSF-2.3"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DOCS="NEWS README"

DEPEND="dev-python/setuptools"
RDEPEND="sys-libs/timezone-data"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="dateutil"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.4.1-locale.patch"

	# Use zoneinfo in /usr/share/zoneinfo.
	sed -e "s/zoneinfo.gettz/gettz/g" -i test.py || die "sed failed"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins example.py sandbox/*.py
	rm -f "${ED}"usr/lib*/python*/site-packages/dateutil/zoneinfo/*.tar.*
}
