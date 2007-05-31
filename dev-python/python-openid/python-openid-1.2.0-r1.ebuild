# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-openid/python-openid-1.2.0-r1.ebuild,v 1.2 2007/05/31 22:23:10 lucass Exp $

NEED_PYTHON=2.3
PYTHON_MODNAME="openid"

inherit distutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="OpenID support for servers and consumers."
HOMEPAGE="http://www.openidenabled.com/openid/libraries/python/"
SRC_URI="http://www.openidenabled.com/resources/downloads/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc examples postgres"

RDEPEND=">=dev-python/python-yadis-1.1.0
	>=dev-python/python-urljr-1.0.1
	postgres? ( dev-python/psycopg )"
DEPEND="${RDEPEND}"

src_install() {
	distutils_src_install
	use doc && dohtml doc/*
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	sed -e '/storetest/d' -i admin/runtests
	PYTHONPATH=. "${python}" admin/runtests || die "tests failed"
}
