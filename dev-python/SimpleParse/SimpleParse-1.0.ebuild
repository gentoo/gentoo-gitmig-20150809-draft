# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/SimpleParse/SimpleParse-1.0.ebuild,v 1.4 2002/10/04 05:26:05 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Parser Generator for mxTextTools."
SRC_URI="http://members.rogers.com/mcfletch/programming/simpleparse/${P}.zip"
HOMEPAGE="http://members.rogers.com/mcfletch/programming/simpleparse/simpleparse.html"
DEPEND="virtual/python
	dev-python/egenix-mx-base"
RDEPEND="${DEPEND}"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} --prefix=/usr --install-data=SIMPLEPARSE_DOCS || die
	find ${D}/SIMPLEPARSE_DOCS -type f -exec dodoc {} \;
	rm -rf ${D}/SIMPLEPARSE_DOCS
}
