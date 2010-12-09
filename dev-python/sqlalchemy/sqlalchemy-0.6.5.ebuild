# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlalchemy/sqlalchemy-0.6.5.ebuild,v 1.2 2010/12/09 11:59:11 hwoarang Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="SQLAlchemy"
MY_P="${MY_PN}-${PV/_}"

DESCRIPTION="Python SQL toolkit and Object Relational Mapper"
HOMEPAGE="http://www.sqlalchemy.org/ http://pypi.python.org/pypi/SQLAlchemy"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc examples firebird mssql mysql postgres +sqlite test"

RDEPEND="firebird? ( dev-python/kinterbasdb )
	mssql? ( dev-python/pymssql )
	mysql? ( dev-python/mysql-python )
	postgres? (
		>=dev-python/psycopg-2
	)
	sqlite? (
		>=dev-db/sqlite-3.3.13
		|| ( >=dev-lang/python-2.5[sqlite] dev-python/pysqlite )
	)"

DEPEND="dev-python/setuptools
	test? (
		>=dev-db/sqlite-3.3.13
		>=dev-python/nose-0.10.4
		|| ( >=dev-lang/python-2.5[sqlite] dev-python/pysqlite )
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	distutils_src_prepare

	# Disable tests hardcoding function call counts specific to Python versions.
	rm -fr test/aaa_profiling

	# Disable failing tests.
	sed -e "s/test_limit_4/_&/" -i test/orm/test_eager_relations.py
	sed -e "s/test_expire_all/_&/" -i test/orm/test_expire.py
	sed -e "s/test_eager_degrade(self)/_&/" -i test/orm/test_mapper.py
	sed -e "s/test_contains_eager(self)/_&/" -i test/orm/test_query.py
}

set_global_options() {
	# Extension modules fail to build with Python 3.
	if [[ "$(python_get_version --major)" == "2" ]]; then
		DISTUTILS_GLOBAL_OPTIONS=("--with-cextensions")
	else
		DISTUTILS_GLOBAL_OPTIONS=()
	fi
}

distutils_src_compile_pre_hook() {
	set_global_options
}

distutils_src_install_pre_hook() {
	set_global_options
}

src_test() {
	testing() {
		[[ "$(python_get_version --major)" == "3" ]] && return
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)" nosetests
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd doc > /dev/null
		rm -fr build
		dohtml -r [a-z]* _images _static || die "dohtml failed"
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "doins failed"
	fi
}
