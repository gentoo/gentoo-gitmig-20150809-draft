# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-openid/python-openid-2.0.1.ebuild,v 1.1 2007/06/23 08:07:33 lucass Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="OpenID support for servers and consumers."
HOMEPAGE="http://www.openidenabled.com/openid/libraries/python/"
SRC_URI="http://www.openidenabled.com/resources/downloads/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples mysql postgres sqlite"

RDEPEND="|| ( >=dev-lang/python-2.5 dev-python/elementtree )
	|| ( >=dev-lang/python-2.5 dev-python/pycrypto )
	sqlite? (
		|| ( >=dev-lang/python-2.5 >=dev-python/pysqlite-2 )
	)
	postgres? ( dev-python/psycopg )
	mysql? ( >=dev-python/mysql-python-1.2.2 )"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="openid"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#Patch to fix confusion with localhost/127.0.0.1
	epatch "${FILESDIR}"/${PN}-2.0.0-gentoo-test_fetchers.diff
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

	"${python}" admin/runtests || die "tests failed"
}
