# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/myghty/myghty-1.1.ebuild,v 1.2 2007/07/04 17:47:36 pythonhead Exp $

NEED_PYTHON=2.4

inherit distutils

KEYWORDS="~amd64 ~x86"

MY_PN=Myghty
MY_P=${MY_PN}-${PV}

DESCRIPTION="Template and view-controller framework derived from HTML::Mason."
HOMEPAGE="http://www.myghty.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
IUSE="doc test"

RDEPEND=">=dev-python/routes-1.0
	dev-python/paste
	dev-python/pastedeploy
	dev-python/pastescript"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S=${WORKDIR}/${MY_P}

src_compile() {
	distutils_src_compile
	if use doc ; then
		einfo "Generation docs as requested..."
		cd doc
		PYTHONPATH=./lib/ python genhtml.py || die "generating docs failed"
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml doc/html/*
}

src_test() {
	PYTHONPATH=./lib/ "${python}" test/alltests.py || die "tests failed"
}
