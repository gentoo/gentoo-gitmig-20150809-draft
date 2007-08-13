# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-1.0.1.ebuild,v 1.8 2007/08/13 20:39:29 dertobi123 Exp $

inherit distutils

IUSE=""
DESCRIPTION="Python wrapper for the local database Sqlite"
SRC_URI="mirror://sourceforge/pysqlite/pysqlite-${PV}.tar.gz"
HOMEPAGE="http://pysqlite.sourceforge.net/"

KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
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
