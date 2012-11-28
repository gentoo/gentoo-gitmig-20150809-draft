# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/passlib/passlib-1.6.1.ebuild,v 1.1 2012/11/28 21:48:39 prometheanfire Exp $

EAPI=4

inherit distutils

DESCRIPTION="comprehensive password hashing framework supporting over 20
schemes"
HOMEPAGE="http://code.google.com/p/passlib/"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"
LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test doc"
DEPEND="dev-python/setuptools
	test? ( dev-python/nose )"
RDEPEND=""

src_install() {
	distutils_src_install
	if use doc; then
		dodoc "${S}"/docs/*
	fi
}

src_test() {
	PYTHONPATH=. "${python}" setup.py nosetests || die "tests failed"
}
