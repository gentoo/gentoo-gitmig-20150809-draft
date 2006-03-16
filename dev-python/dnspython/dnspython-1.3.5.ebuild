# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dnspython/dnspython-1.3.5.ebuild,v 1.5 2006/03/16 11:41:54 corsair Exp $

inherit distutils

DESCRIPTION="DNS toolkit for Python."
HOMEPAGE="http://www.dnspython.org/"
SRC_URI="http://www.dnspython.org/kits/stable/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm hppa ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="virtual/python
	sys-devel/make"

src_install() {
	distutils_src_install
	dodoc TODO
	dodir /usr/share/doc/${P}

	cp -r examples ${D}/usr/share/doc/${P}
	dodir /usr/share/${PN}
	cp -r tests ${D}/usr/share/${PN}
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
	make || die "Unit tests failed!"
}

