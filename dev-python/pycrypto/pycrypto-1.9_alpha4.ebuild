# Copyright 2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycrypto/pycrypto-1.9_alpha4.ebuild,v 1.2 2002/10/17 16:36:53 bjb Exp $

DESCRIPTION="Python cryptography toolkit."
HOMEPAGE="http://www.amk.ca/python/code/crypto.html"
LICENSE="freedist"

DEPEND="virtual/glibc
	dev-lang/python"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86 alpha"
SRC_URI="http://www.amk.ca/files/python/${P/_alpha/a}.tar.gz"

S="${WORKDIR}/${P/_alpha/a}"

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc ACKS ChangeLog LICENSE MANIFEST PKG-INFO README TODO
}
