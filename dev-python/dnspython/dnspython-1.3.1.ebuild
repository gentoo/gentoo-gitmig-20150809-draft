# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dnspython/dnspython-1.3.1.ebuild,v 1.2 2004/07/21 07:33:47 dholm Exp $

inherit distutils

DESCRIPTION="DNS toolkit for Python."
HOMEPAGE="http://www.dnspython.org/"
SRC_URI="http://www.dnspython.org/kits/stable/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=virtual/python-2.2
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
	einfo "or read the HTML documentation at the dnspython home page."
	einfo
}

src_test() {
	export PYTHONPATH="${S}/build/lib:${PYTHONPATH}"
	cd tests
	make || die "Unit tests failed!"
}

