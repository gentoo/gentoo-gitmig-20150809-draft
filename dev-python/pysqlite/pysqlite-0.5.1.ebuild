# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-0.5.1.ebuild,v 1.11 2004/10/23 08:13:16 mr_bones_ Exp $

inherit distutils

IUSE=""
DESCRIPTION="Python wrapper for the local database Sqlite"
SRC_URI="mirror://sourceforge/pysqlite/pysqlite-${PV}.tar.gz"
HOMEPAGE="http://pysqlite.sourceforge.net/"

KEYWORDS="x86 alpha amd64 ppc sparc ppc-macos"
LICENSE="pysqlite"
SLOT="0"

DEPEND="virtual/python
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
