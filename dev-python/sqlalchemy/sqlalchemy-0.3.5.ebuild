# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlalchemy/sqlalchemy-0.3.5.ebuild,v 1.2 2007/03/20 08:23:56 lucass Exp $

NEED_PYTHON=2.4

inherit distutils

MY_P=SQLAlchemy-${PV}

DESCRIPTION="Python SQL toolkit and Object Relational Mapper."
HOMEPAGE="http://www.sqlalchemy.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="doc examples firebird mssql mysql postgres sqlite test"
KEYWORDS="~amd64 ~x86"

# note: if you use psycopg-1, then you need egenix-mx-base
RDEPEND="firebird? ( dev-python/kinterbasdb )
	mssql? ( dev-python/pymssql )
	mysql? ( dev-python/mysql-python )
	postgres? (
		|| (
			( >=dev-python/psycopg-2 )
			( <dev-python/psycopg-2 dev-python/egenix-mx-base )
		)
	)
	sqlite? ( || ( dev-python/pysqlite >=dev-lang/python-2.5 ) )"

DEPEND="dev-python/setuptools
	test? ( || ( dev-python/pysqlite >=dev-lang/python-2.5 ) )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# skip testorderby and testorderby_desc
	# which require sqlite-3.3.13 to pass
	sed -i \
		-e '1048,1060d' \
		-e '1142,1155d' \
		test/orm/mapper.py || die "sed failed"

	sed -i -e 's/sleep(3)/sleep(5)/' \
		test/engine/pool.py || die "sed failed"

	# fix alltests.py to return 1 on failure
	sed -i \
		-e '1iimport sys' \
		-e 's/\(testbase\.run.*\)/sys.exit(not \1.wasSuccessful())/' \
		test/alltests.py || die "sed failed"
}

src_install() {
	distutils_src_install

	use doc && dohtml doc/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	PYTHONPATH="./test/" "${python}" test/alltests.py || die "tests failed"
}
