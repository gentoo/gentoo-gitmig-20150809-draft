# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-urljr/python-urljr-1.0.1.ebuild,v 1.2 2007/05/31 20:56:01 lucass Exp $


NEED_PYTHON=2.3
PYTHON_MODNAME="urljr"

inherit distutils eutils


DESCRIPTION="JanRain's URL Utilities"
HOMEPAGE="http://www.openidenabled.com/openid/libraries/python/"
SRC_URI="http://www.openidenabled.com/resources/downloads/python-openid/${P}.tar.gz"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="curl test"
RDEPEND="curl? ( >=dev-python/pycurl-7.15.1 )
	test? ( >=dev-python/pycurl-7.15.1 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	#Test fails if it finds 'localhost' instead of '127.0.0.1'
	epatch ${FILESDIR}/${P}-gentoo-test_fetchers.patch
}

src_test() {
	PYTHONPATH=. "${python}" admin/runtests || die "tests failed"
}

