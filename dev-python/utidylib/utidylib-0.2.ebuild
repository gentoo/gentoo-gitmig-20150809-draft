# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/utidylib/utidylib-0.2.ebuild,v 1.6 2007/07/26 18:21:23 corsair Exp $

inherit distutils eutils

MY_P="uTidylib-${PV}"

DESCRIPTION="TidyLib Python wrapper"
HOMEPAGE="http://utidylib.berlios.de/"
SRC_URI="http://download.berlios.de/utidylib/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-lang/python-2.3
	app-text/htmltidy
	dev-python/ctypes"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( dev-python/epydoc )
	test? ( dev-python/twisted )"

PYTHON_MODNAME="tidy"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-tests-twisted-2.1-compat.patch"
	epatch "${FILESDIR}/${P}-no-docs-in-site-packages.patch"
	epatch "${FILESDIR}/${P}-fix_tests.patch"
}

src_compile() {
	distutils_src_compile
	if use doc; then
		python gendoc.py || die "building api docs failed"
	fi
}

src_test() {
	trial tidy || die "tests failed"
}

src_install() {
	distutils_src_install
	use doc && dohtml -r apidoc
}
