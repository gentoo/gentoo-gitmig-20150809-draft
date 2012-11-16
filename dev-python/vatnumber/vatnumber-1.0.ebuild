# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vatnumber/vatnumber-1.0.ebuild,v 1.2 2012/11/16 14:59:27 idella4 Exp $

EAPI="3"
PYTHON_DEPEND="2"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

DESCRIPTION="Module to validate VAT numbers"
HOMEPAGE="http://code.google.com/p/vatnumber/"
SRC_URI="http://vatnumber.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test vies"

RDEPEND="vies? ( dev-python/suds )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/suds )"

PYTHON_MODNAME="vatnumber"

src_prepare() {
	epatch "${FILESDIR}"/${P}-skiptest.patch
}

src_install() {
	distutils_src_install
	dodoc COPYRIGHT README CHANGELOG
}
