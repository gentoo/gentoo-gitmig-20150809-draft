# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pkgcore/pkgcore-0.7.7-r1.ebuild,v 1.1 2011/12/02 10:11:43 ferringb Exp $

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
	>=dev-python/snakeoil-0.4.4
	|| ( >=dev-lang/python-2.5 dev-python/pycrypto )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx dev-python/pyparsing )"

DOCS="AUTHORS NEWS"

pkg_setup() {
	# disable snakeoil 2to3 caching...
	unset PY2TO3_CACHEDIR
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-${PV}-IFS-manipulation.patch"
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
