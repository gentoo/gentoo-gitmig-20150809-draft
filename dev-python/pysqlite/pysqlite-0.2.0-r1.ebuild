# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-0.2.0-r1.ebuild,v 1.2 2002/11/03 19:27:01 roughneck Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="Python wrapper for the local database Sqlite"
SRC_URI="mirror://sourceforge/pysqlite/pysqlite-${PV}.tar.gz"
HOMEPAGE="http://www.hwaci.com/sw/sqlite/"
DEPEND="virtual/python
		dev-db/sqlite"
RDEPEND=""
KEYWORDS="ppc x86 sparc sparc64 alpha"
LICENSE="pysqlite"
SLOT="0"

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc README
			
	# Need to do the examples explicitly since dodoc
	# doesn't do directories properly
	mkdir -p ${D}/usr/share/doc/${PF}/examples || die
	cp -r ${S}/examples/* ${D}/usr/share/doc/${PF}/examples || die
}
