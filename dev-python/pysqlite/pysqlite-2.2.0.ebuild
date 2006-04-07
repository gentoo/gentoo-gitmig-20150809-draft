# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-2.2.0.ebuild,v 1.1 2006/04/07 15:21:56 marienz Exp $

inherit distutils

DESCRIPTION="Python wrapper for the local database Sqlite"
SRC_URI="http://initd.org/pub/software/pysqlite/releases/${PV:0:3}/${PV}/pysqlite-${PV}.tar.gz"
HOMEPAGE="http://initd.org/tracker/pysqlite/"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
LICENSE="pysqlite"
SLOT="2"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-db/sqlite-3.1"


src_compile() {
	if ! use doc; then
		export NODOCS=1
	fi
	distutils_src_compile
}

src_install() {
	distutils_src_install

	pushd doc

	insinto /usr/share/doc/${PF}
	doins -r code || die "code examples doins failed"

	dohtml -r . || die "dohtml failed"

	popd
}

src_test() {
	cd build/lib*
	# tests use this as a nonexistant file
	addpredict /foo/bar
	PYTHONPATH=. "${python}" -c \
		"from pysqlite2.test import test;import sys;sys.exit(test())" \
		|| die "test failed"
}
