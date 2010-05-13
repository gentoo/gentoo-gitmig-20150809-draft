# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rdflib/rdflib-3.0.0.ebuild,v 1.1 2010/05/13 21:32:32 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="RDF library containing a triple store and parser/serializer"
HOMEPAGE="http://rdflib.net/ http://pypi.python.org/pypi/rdflib"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-linux"
IUSE="berkdb examples mysql redland sqlite zodb"

RDEPEND="mysql? ( dev-python/mysql-python )
	sqlite? (
		>=dev-db/sqlite-3.3.13
		|| ( dev-python/pysqlite >=dev-lang/python-2.5 ) )
	berkdb? ( sys-libs/db )
	redland? ( dev-libs/redland-bindings[python] )
	zodb? ( net-zope/zodb )"
DEPEND="${RDEPEND}
	test? ( dev-python/nose )"
RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib)" "$(PYTHON)" run_tests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
