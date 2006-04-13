# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ctypes/ctypes-0.9.9.3.ebuild,v 1.3 2006/04/13 13:41:45 tcort Exp $

inherit eutils distutils

DESCRIPTION="Python module allowing to create and manipulate C data types."
HOMEPAGE="http://starship.python.net/crew/theller/ctypes/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.3.3"

DOCS="README.txt NEWS.txt LICENSE.txt docs/*"

src_test() {
	mkdir "${T}/tests"
	"${python}" setup.py install --home="${T}/tests"
	PYTHONPATH="${T}/tests/lib/python" "${python}" ctypes/test/runtests.py || \
		die "tests failed"
	rm -rf "${T}/tests"
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins -r samples/*
}