# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/ScientificPython/ScientificPython-2.2-r1.ebuild,v 1.1 2002/07/15 19:53:59 george Exp $


S=${WORKDIR}/${P}
DESCRIPTION="scientific python module"
SRC_URI="http://starship.python.net/crew/hinsen/${P}.tar.gz"
HOMEPAGE="http://starship.python.net/crew/hinsen/scientific.html"

DEPEND=">=dev-lang/python-2.0-r4
        >=dev-python/Numeric-19.0
        >=app-sci/netcdf-3.0"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"
	
src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --prefix=${D}/usr || die
	
	dodoc MANIFEST.in COPYRIGHT README*
	cd Doc
	dodoc CHANGELOG
	dohtml HTML/*

	dodir /usr/share/doc/${P}/pdf
	insinto /usr/share/doc/${P}/pdf
	doins PDF/*
	#for p in PDF/*.pdf; do
	#	dodoc $p
	#done

}
