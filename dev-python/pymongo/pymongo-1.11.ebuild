# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymongo/pymongo-1.11.ebuild,v 1.1 2011/05/12 09:22:56 ultrabug Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Python driver for MongoDB"
HOMEPAGE="http://github.com/mongodb/mongo-python-driver"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="|| ( dev-lang/python:2.7 dev-lang/python:2.6 dev-lang/python:2.5 >=dev-python/celementtree-1.0.5 )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc?  ( dev-python/sphinx )
	test? ( dev-db/mongodb )"

pkg_setup() {
	if use test; then
		ewarn "WARNING: You need a running instance of mongod in order to test this package !"
		sleep 3
	fi
}

src_compile() {
	distutils_src_compile

	if use doc; then
		mkdir html
		sphinx-build doc html || die "building docs failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r html/* || die "Error installing docs"
	fi
}
