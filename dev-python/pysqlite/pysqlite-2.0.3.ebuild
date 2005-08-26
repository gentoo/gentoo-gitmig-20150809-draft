# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-2.0.3.ebuild,v 1.2 2005/08/26 03:41:05 agriffis Exp $

inherit distutils

IUSE="doc"
DESCRIPTION="Python wrapper for the local database Sqlite"
SRC_URI="http://initd.org/pub/software/pysqlite/releases/${PV:0:3}/${PV}/pysqlite-${PV}.tar.gz"
HOMEPAGE="http://initd.org/tracker/pysqlite/"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
LICENSE="pysqlite"
SLOT="2"

DEPEND=">=dev-lang/python-2.3
	>=dev-db/sqlite-3.1"

src_unpack() {
	unpack ${A}
	sed -i -e "s:data_files = data_files,:data_files = [],:" ${S}/setup.py
}

src_install() {
	distutils_src_install
	# Need to do the examples explicitly since dodoc
	# doesn't do directories properly
	if use doc ; then
		cp -r ${S}/doc/*.{html,txt,css} ${D}/usr/share/doc/${PF} || die
		dodir /usr/share/doc/${PF}/code || die
		cp -r ${S}/doc/code/* ${D}/usr/share/doc/${PF}/code || die
	fi
}
