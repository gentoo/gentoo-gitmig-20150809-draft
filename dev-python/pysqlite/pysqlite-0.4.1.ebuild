# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-0.4.1.ebuild,v 1.1 2003/05/16 09:11:37 liquidx Exp $

inherit distutils

IUSE=""
DESCRIPTION="Python wrapper for the local database Sqlite"
SRC_URI="mirror://sourceforge/pysqlite/pysqlite-${PV}.tar.gz"
HOMEPAGE="http://pysqlite.sourceforge.net/"

KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="pysqlite"
SLOT="0"

DEPEND="virtual/python
	dev-db/sqlite"

src_install() {
	distutils_src_install
	# Need to do the examples explicitly since dodoc
	# doesn't do directories properly
	dodir /usr/share/doc/${PF}/examples || die
	cp -r ${S}/examples/* ${D}/usr/share/doc/${PF}/examples || die
}
