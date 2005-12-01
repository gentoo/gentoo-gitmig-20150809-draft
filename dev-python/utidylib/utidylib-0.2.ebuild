# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/utidylib/utidylib-0.2.ebuild,v 1.1 2005/12/01 00:19:37 marienz Exp $

inherit distutils

MY_P="uTidylib-${PV}"

DESCRIPTION="TidyLib Python wrapper"
HOMEPAGE="http://utidylib.berlios.de/"
SRC_URI="http://download.berlios.de/utidylib/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc test"

RDEPEND=">=dev-lang/python-2.3
	dev-python/ctypes
	app-text/htmltidy"

DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc )
	test? ( dev-python/twisted )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-tests-twisted-2.1-compat.patch"
	epatch "${FILESDIR}/${P}-no-docs-in-site-packages.patch"
}

src_compile() {
	distutils_src_compile
	if use doc; then
		python gendoc.py || die "building api docs failed"
	fi
}

src_test() {
	trial tidy/test_tidy.py || die "tests failed"
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r apidoc
	fi
}
