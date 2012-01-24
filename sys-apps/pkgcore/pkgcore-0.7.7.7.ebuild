# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pkgcore/pkgcore-0.7.7.7.ebuild,v 1.1 2012/01/24 11:53:49 ferringb Exp $

EAPI="3"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

DESCRIPTION="pkgcore package manager"
HOMEPAGE="http://pkgcore.googlecode.com/"
SRC_URI="http://pkgcore.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="-doc build"

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/snakeoil-0.4.5
	|| ( >=dev-lang/python-2.5 dev-python/pycrypto )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx dev-python/pyparsing )"

DOCS="AUTHORS NEWS"

pkg_setup() {
	# disable snakeoil 2to3 caching...
	unset PY2TO3_CACHEDIR
	python_pkg_setup
}

src_compile() {
	distutils_src_compile

	if use doc; then
		python setup.py build_docs || die "doc building failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r build/sphinx/html/*
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	pplugincache
}
