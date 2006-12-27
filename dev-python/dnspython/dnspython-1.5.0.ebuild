# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dnspython/dnspython-1.5.0.ebuild,v 1.1 2006/12/27 00:37:20 dev-zero Exp $

inherit distutils

DESCRIPTION="DNS toolkit for Python"
HOMEPAGE="http://www.dnspython.org/"
SRC_URI="http://www.dnspython.org/kits/stable/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="TODO"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins -r examples

	insinto /usr/share/${PN}
	doins -r tests
}

pkg_postinst() {
	einfo
	einfo "Documentation is sparse at the moment. Use pydoc,"
	einfo "or read the HTML documentation at the dnspython's home page."
	einfo
}

src_test() {
	export PYTHONPATH="${S}/build/lib:${PYTHONPATH}"
	cd tests
	emake || die "Unit tests failed!"
}
