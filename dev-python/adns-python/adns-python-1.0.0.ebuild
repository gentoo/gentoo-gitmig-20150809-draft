# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/adns-python/adns-python-1.0.0.ebuild,v 1.1 2003/03/03 23:41:50 foser Exp $

DESCRIPTION="Python bindings for ADNS"
HOMEPAGE="http://dustman.net/andy/python/adns-python"
SRC_URI="http://dustman.net/andy/python/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/python
	=net-libs/adns-1.0*"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --prefix=${D}/usr || die

	dodoc README
}
