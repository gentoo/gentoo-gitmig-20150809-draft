# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header $

S=${WORKDIR}/${P}
DESCRIPTION="A collection of libraries to process XML with Python."
SRC_URI="mirror://sourceforge/pyxml/${P}.tar.gz"
HOMEPAGE="http://pyxml.sourceforge.net/"

DEPEND="virtual/python"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="PYTHON"


src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --prefix=${D}/usr || die

	dodoc MANIFEST README *
}


