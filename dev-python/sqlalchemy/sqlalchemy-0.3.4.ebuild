# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlalchemy/sqlalchemy-0.3.4.ebuild,v 1.1 2007/01/24 11:26:47 dev-zero Exp $

inherit distutils

MY_P=SQLAlchemy-${PV}

DESCRIPTION="Python SQL toolkit and Object Relational Mapper."
HOMEPAGE="http://www.sqlalchemy.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="firebird mssql mysql postgres sqlite test"
KEYWORDS="~amd64 ~x86"

# note: if you use psycopg-1, then you need egenix-mx-base
RDEPEND=">=dev-lang/python-2.4
	firebird? ( dev-python/kinterbasdb )
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

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd "${S}/test"
	sed -e 's/\\\.p/.p/g' \
		-i sql/testtypes.py || die "sed failed"
}

src_install() {
	distutils_src_install
	dohtml doc/*

	insinto /usr/share/doc/${PF}
	doins -r examples
}

src_test() {
	PYTHONPATH="./test/" python test/alltests.py
}
