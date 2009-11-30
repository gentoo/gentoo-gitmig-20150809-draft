# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/storm/storm-0.16.0.ebuild,v 1.1 2009/11/30 14:37:38 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="An object-relational mapper for Python developed at Canonical."
HOMEPAGE="https://storm.canonical.com/FrontPage http://pypi.python.org/pypi/storm"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mysql postgres sqlite test"

RDEPEND="mysql? ( dev-python/mysql-python )
	postgres? ( =dev-python/psycopg-2* )
	sqlite? ( || ( >=dev-lang/python-2.5[sqlite] dev-python/pysqlite ) )"
DEPEND="dev-python/setuptools
	test? ( || ( >=dev-lang/python-2.5[sqlite] dev-python/pysqlite ) )"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="tests/tutorial.txt"

src_test() {
	if use mysql; then
		elog "To run the MySQL-tests, you need:"
		elog "  - a running mysql-server"
		elog "  - an already existing database 'db'"
		elog "  - a user 'user' with full permissions on that database"
		elog "  - and an environment variable STORM_MYSQL_URI=\"mysql://user:password@host:1234/db\""
	fi
	if use postgres; then
		elog "To run the PostgreSQL-tests, you need:"
		elog "  - a running postgresql-server"
		elog "  - an already existing database 'db'"
		elog "  - a user 'user' with full permissions on that database"
		elog "  - and an environment variable STORM_POSTGRES_URI=\"postgres://user:password@host:1234/db\""
	fi

	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)" "$(PYTHON)" test
	}
	python_execute_function testing
}
