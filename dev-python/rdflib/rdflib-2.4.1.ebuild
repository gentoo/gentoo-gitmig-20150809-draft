# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rdflib/rdflib-2.4.1.ebuild,v 1.1 2009/08/10 00:09:24 arfrever Exp $

EAPI="2"
NEED_PYTHON="2.3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="RDF library containing a triple store and parser/serializer"
HOMEPAGE="http://rdflib.net/"
SRC_URI="http://rdflib.net/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="berkdb examples mysql redland sqlite zodb"

DEPEND=">=dev-python/setuptools-0.6_rc5"
#	test? ( dev-python/nose )"
RDEPEND="mysql? ( dev-python/mysql-python )
	sqlite? (
		>=dev-db/sqlite-3.3.13
		|| ( dev-python/pysqlite >=dev-lang/python-2.5 ) )
	berkdb? ( sys-libs/db )
	redland? ( dev-libs/redland-bindings[python] )
	zodb? ( net-zope/zodb )"

RESTRICT="test"
RESTRICT_PYTHON_ABIS="3*"

PYTHON_MODNAME="rdflib rdflib_tools"

src_prepare() {
	# Don't install tests. Remove tests_require to prevent setuptools
	# from trying to download deps that it can't find
	sed -i \
		-e '/packages = find_packages/s/"test"/&, "test.*"/' \
		-e "/tests_require/d" \
		setup.py || die "sed in setup.py failed"
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" setup.py test
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
