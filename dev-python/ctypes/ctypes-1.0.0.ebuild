# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ctypes/ctypes-1.0.0.ebuild,v 1.3 2007/03/29 08:15:00 corsair Exp $

inherit distutils

DESCRIPTION="Python module allowing to create and manipulate C data types."
HOMEPAGE="http://starship.python.net/crew/theller/ctypes/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.3.3"

DOCS="ACKS ANNOUNCE LICENSE.txt"

src_test() {
	mkdir "${T}/tests"
	"${python}" setup.py install --home="${T}/tests"
	PYTHONPATH="${T}/tests/$(get_libdir)/python" \
		"${python}" ctypes/test/runtests.py || die "tests failed"
	rm -rf "${T}/tests"
}

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/manual
	doins -r docs/manual/*
}
