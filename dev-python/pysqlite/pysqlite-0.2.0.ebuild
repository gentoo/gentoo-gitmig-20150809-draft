# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-0.2.0.ebuild,v 1.1 2002/07/30 08:32:24 rphillips Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="Python wrapper for the local database Sqlite"
SRC_URI="mirror://sourceforge/pysqlite/pysqlite-${PV}.tar.gz"
HOMEPAGE="http://www.hwaci.com/sw/sqlite/"
DEPEND="virtual/python
		dev-db/sqlite"
RDEPEND="${DEPEND}"
KEYWORDS="x86"
LICENSE="pysqlite"
SLOT="0"

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc *.txt examples/*
}
