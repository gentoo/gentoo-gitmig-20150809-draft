# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-1.0.1.ebuild,v 1.4 2005/08/01 18:54:46 pythonhead Exp $

inherit distutils

IUSE=""
DESCRIPTION="Python wrapper for the local database Sqlite"
SRC_URI="mirror://sourceforge/pysqlite/pysqlite-${PV}.tar.gz"
HOMEPAGE="http://pysqlite.sourceforge.net/"

KEYWORDS="~amd64 sparc x86"
LICENSE="pysqlite"
SLOT="0"

DEPEND=">=dev-lang/python-2.2
	=dev-db/sqlite-2*"

src_unpack() {
	unpack ${A}
	# distutils expects to find setup.py in ${S}
	mv ${WORKDIR}/pysqlite ${S}
}

src_install() {
	distutils_src_install
	# Need to do the examples explicitly since dodoc
	# doesn't do directories properly
	dodir /usr/share/doc/${PF}/examples || die
	cp -r ${S}/examples/* ${D}/usr/share/doc/${PF}/examples || die
}
