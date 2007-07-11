# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webhelpers/webhelpers-0.2.2.ebuild,v 1.3 2007/07/11 06:19:47 mr_bones_ Exp $

NEED_PYTHON=2.3

inherit distutils

KEYWORDS="~amd64 ~x86"

MY_PN=WebHelpers
MY_P=${MY_PN}-${PV}

DESCRIPTION="A library of helper functions intended to make writing templates in web applications easier."
HOMEPAGE="http://pylonshq.com/WebHelpers/"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE="doc test"

RDEPEND=">=dev-python/simplejson-1.4
	>=dev-python/routes-1.1"
DEPEND="${RDEPEND}
	doc? ( dev-python/pudge dev-python/buildutils )
	test? ( dev-python/nose )
	dev-python/setuptools"

S=${WORKDIR}/${MY_P}

src_compile() {
	distutils_src_compile
	if use doc ; then
		einfo "Generating docs as requested..."
		PYTHONPATH=. "${python}" setup.py pudge || die "generating docs failed"
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/html/*
}

src_test() {
	PYTHONPATH=. "${python}" setup.py nosetests || die "tests failed"
}
