# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-2.5.6.ebuild,v 1.2 2009/12/20 17:30:40 jer Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python wrapper for the local database Sqlite"
HOMEPAGE="http://code.google.com/p/pysqlite/ http://pypi.python.org/pypi/pysqlite"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="pysqlite"
SLOT="2"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="examples"

DEPEND=">=dev-db/sqlite-3.1"
RDEPEND=${DEPEND}
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="pysqlite2"

src_prepare() {
	distutils_src_prepare

	# Don't install pysqlite2.test.
	sed -i -e 's/, "pysqlite2.test"//' setup.py || die "sed setup.py failed"

	# Fix encoding.
	sed -i -e "s/\(coding: \)ISO-8859-1/\1utf-8/" lib/{__init__.py,dbapi2.py} || die "sed lib/{__init__.py,dbapi2.py} failed"

	# Workaround to make tests work without installing them.
	sed -i -e "s/pysqlite2.test/test/" lib/test/__init__.py || die "sed lib/test/__init__.py failed"
}

src_test() {
	cd lib
	testing() {
		PYTHONPATH="$(ls -d ../build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" -c "from test import test;import sys;sys.exit(test())"
	}
	python_execute_function testing
}

src_install() {
	[[ -z "${ED}" ]] && local ED="${D}"
	distutils_src_install

	rm -rf "${ED}usr/pysqlite2-doc"

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r doc/includes/sqlite3
	fi
}
