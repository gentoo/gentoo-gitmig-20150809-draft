# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyXML/PyXML-0.7.ebuild,v 1.14 2003/06/12 20:36:30 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A collection of libraries to process XML with Python."
SRC_URI="mirror://sourceforge/pyxml/${P}.tar.gz"
HOMEPAGE="http://pyxml.sourceforge.net/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="PYTHON"


src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --prefix=${D}/usr || die

	dodoc MANIFEST README *
}


