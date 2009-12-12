# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-openid/python-openid-2.2.4.ebuild,v 1.3 2009/12/12 22:25:38 arfrever Exp $

EAPI="2"

NEED_PYTHON="2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="OpenID support for servers and consumers."
HOMEPAGE="http://www.openidenabled.com/openid/libraries/python/"
SRC_URI="http://www.openidenabled.com/files/${PN}/packages/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples mysql postgres sqlite"

RDEPEND="mysql? ( >=dev-python/mysql-python-1.2.2 )
	postgres? ( dev-python/psycopg )
	sqlite? ( || ( dev-lang/python[sqlite] >=dev-python/pysqlite-2 ) )"
DEPEND="${RDEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="openid"

src_prepare() {
	distutils_src_prepare

	# Patch to fix confusion with localhost/127.0.0.1
	epatch "${FILESDIR}/${PN}-2.0.0-gentoo-test_fetchers.diff"

	# Disable broken tests from from examples/djopenid.
	sed -e "s/django_failures =.*/django_failures = 0/" -i admin/runtests || die "sed admin/runtests failed"
}

src_test() {
	# Remove test that requires running db server.
	sed -e '/storetest/d' -i admin/runtests

	testing() {
		"$(PYTHON)" admin/runtests
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	use doc && dohtml doc/*

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
