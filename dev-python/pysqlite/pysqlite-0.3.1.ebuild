# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-0.3.1.ebuild,v 1.10 2004/08/05 23:31:05 arj Exp $

inherit distutils

IUSE=""
DESCRIPTION="Python wrapper for the local database Sqlite"
SRC_URI="mirror://sourceforge/pysqlite/pysqlite-${PV}.tar.gz"
HOMEPAGE="http://www.hwaci.com/sw/sqlite/"

KEYWORDS="ppc x86 sparc alpha"
LICENSE="pysqlite"
SLOT="0"

DEPEND="virtual/python
	=dev-db/sqlite-2*"

src_install() {
	distutils_src_install
	# Need to do the examples explicitly since dodoc
	# doesn't do directories properly
	dodir /usr/share/doc/${PF}/examples || die
	cp -r ${S}/examples/* ${D}/usr/share/doc/${PF}/examples || die
}
