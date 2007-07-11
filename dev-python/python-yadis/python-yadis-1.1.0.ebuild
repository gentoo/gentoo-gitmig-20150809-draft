# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-yadis/python-yadis-1.1.0.ebuild,v 1.3 2007/07/11 06:19:47 mr_bones_ Exp $

PYTHON_MODNAME="yadis"
NEED_PYTHON=2.3

inherit distutils eutils

DESCRIPTION="Yadis service discovery library."
HOMEPAGE="http://www.openidenabled.com/yadis/libraries/python/"
SRC_URI="http://www.openidenabled.com/resources/downloads/python-openid/${P}.tar.gz"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"
RDEPEND="test? ( >=dev-python/pyflakes-0.2.1 )
	|| ( <dev-lang/python-2.5 dev-python/elementtree )"

src_unpack() {
	unpack ${A}
	cd ${S}
	#Fix broken test
	epatch ${FILESDIR}/${P}-gentoo-test.patch
}

src_test() {
	#Test is a shell script
	./admin/runtests || die "tests failed"
	einfo "The pyflake output about XML* redefinitions can be safely ignored"
}
