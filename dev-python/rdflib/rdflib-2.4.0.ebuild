# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rdflib/rdflib-2.4.0.ebuild,v 1.3 2008/12/23 17:30:39 maekke Exp $

NEED_PYTHON="2.3"

inherit distutils

DESCRIPTION="RDF library containing a triple store and parser/serializer"
HOMEPAGE="http://rdflib.net/"
SRC_URI="http://rdflib.net/${P}.tar.gz"
LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="berkdb examples mysql redland sqlite test zodb"
DEPEND=">=dev-python/setuptools-0.6_rc5
	test? ( <dev-python/nose-0.10.0 )"
RDEPEND="mysql? ( dev-python/mysql-python )
	sqlite? (
		>=dev-db/sqlite-3.3.13
		|| ( dev-python/pysqlite >=dev-lang/python-2.5 ) )
	berkdb? ( sys-libs/db )
	redland? ( dev-libs/redland-bindings )
	zodb? ( net-zope/zodb )"

pkg_setup() {
	if use redland && ! built_with_use dev-libs/redland-bindings python  ; then
		eerror "In order to have rdflib working with redland support, you need"
		eerror "to have dev-libs/redland-bindings emerged with 'python' in"
		eerror "your USE flags."
		die "dev-libs/redland-bindings is missing the python USE flag."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Don't install tests. Remove tests_require to prevent setuptools
	# from trying to download deps that it can't find
	sed -i \
		-e "s/\(find_packages(\)/\1exclude=('test','test.*')/" \
		-e "/tests_require/d" \
		setup.py || die "sed in setup.py failed"
}

src_install() {
	distutils_src_install
	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}

src_test() {
	${python} setup.py test || die "tests failed"
}
