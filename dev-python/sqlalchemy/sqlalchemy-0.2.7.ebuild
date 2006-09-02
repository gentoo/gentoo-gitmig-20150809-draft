# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlalchemy/sqlalchemy-0.2.7.ebuild,v 1.1 2006/09/02 11:42:52 liquidx Exp $

inherit distutils python

MY_P=SQLAlchemy-${PV}
DESCRIPTION="Python SQL toolkit and Object Relational Mapper."
HOMEPAGE="http://www.sqlalchemy.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
IUSE="firebird mysql postgres sqlite"
KEYWORDS="~amd64 ~x86"

# note: if you use psycopg-1, then you need egenix-mx-base
RDEPEND=">=dev-lang/python-2.4
	firebird? ( dev-python/kinterbasdb )
	mssql? ( dev-python/pymssql )
	mysql? ( dev-python/mysql-python )
	postgres? (
		|| ( ( >=dev-python/psycopg-2 )
			 ( <dev-python/psycopg-1 dev-python/egenix-mx-base )
		   )
	)
	sqlite? ( dev-python/pysqlite )"

DEPEND="dev-python/setuptools"

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

	insinto /usr/share/doc/${PV}
	doins -r examples
}

src_test() {
	if use sqlite; then
		python_version
		export PYTHONPATH="${PYTHONPATH}:../lib/"
		cd "${S}/lib/${PN}"
		python "/usr/lib/python${PYVER}/compileall.py" .
		cd "${S}/test"
		python alltests.py
	fi
}
