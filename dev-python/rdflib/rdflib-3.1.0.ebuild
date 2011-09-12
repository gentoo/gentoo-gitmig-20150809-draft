# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rdflib/rdflib-3.1.0.ebuild,v 1.2 2011/09/12 21:20:56 neurogeek Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="RDF library containing a triple store and parser/serializer"
HOMEPAGE="http://www.rdflib.net/ http://pypi.python.org/pypi/rdflib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-linux"
IUSE="berkdb examples mysql redland sqlite test"

RDEPEND="berkdb? ( dev-python/bsddb3 )
	mysql? ( dev-python/mysql-python )
	redland? ( dev-libs/redland-bindings[python] )
	sqlite? ( || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] dev-lang/python:2.5[sqlite] dev-python/pysqlite ) )"
DEPEND="${RDEPEND}
	test? ( dev-python/nose )"

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
		doins -r examples/* || die "Installation of examples failed"
	fi
}
