# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycrypto/pycrypto-1.9_alpha4.ebuild,v 1.11 2005/01/25 01:54:54 lucass Exp $

DESCRIPTION="Python cryptography toolkit."
HOMEPAGE="http://www.amk.ca/python/code/crypto.html"
LICENSE="freedist"

DEPEND="virtual/libc
	dev-lang/python"

SLOT="0"
KEYWORDS="x86 alpha"
SRC_URI="http://www.amk.ca/files/python/crypto/${P/_alpha/a}.tar.gz"
IUSE=""

S="${WORKDIR}/${P/_alpha/a}"

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc ACKS ChangeLog LICENSE MANIFEST PKG-INFO README TODO
}
