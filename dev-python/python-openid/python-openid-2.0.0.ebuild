# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-openid/python-openid-2.0.0.ebuild,v 1.1 2007/06/07 23:47:50 pythonhead Exp $


NEED_PYTHON=2.3
PYTHON_MODNAME="openid"

inherit distutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="OpenID support for servers and consumers."
HOMEPAGE="http://www.openidenabled.com/openid/libraries/python/"
SRC_URI="http://www.openidenabled.com/resources/downloads/${PN}/${P}.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc examples mysql postgres sqlite"

RDEPEND="|| ( <dev-lang/python-2.5 dev-python/elementtree )
	|| ( <dev-lang/python-2.5 dev-python/pycrypto )
	postgres? ( dev-python/psycopg )
	sqlite? ( >=dev-python/pysqlite-2.3.3 )
	mysql? ( >=dev-python/mysql-python-1.2.2 )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	#Patch to fix confusion with localhost/127.0.0.1
	epatch ${FILESDIR}/${P}-gentoo-test_fetchers.diff
}

src_install() {
	distutils_src_install
	use doc && dohtml doc/*
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	#Remove test that requires running db server
	sed -e '/storetest/d' -i admin/runtests
	PYTHONPATH=. "${python}" admin/runtests || die "tests failed"
}
