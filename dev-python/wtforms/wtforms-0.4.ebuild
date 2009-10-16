# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wtforms/wtforms-0.4.ebuild,v 1.1 2009/10/16 10:02:48 djc Exp $

SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="WTForms"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Flexible forms validation and rendering library for python web development"
HOMEPAGE="http://wtforms.simplecodes.com/"
SRC_URI="http://pypi.python.org/packages/source/W/${MY_PN}/${MY_P}.zip"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

S="${WORKDIR}/${MY_P}"

DEPEND="doc? ( >=dev-python/sphinx-0.6 )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="AUTHORS.txt CHANGES.txt INSTALL.txt LICENSE.txt README.txt"

src_compile() {
	distutils_src_compile
	if use doc; then
		cd "${S}/docs"
		PYTHONPATH=.. emake html || die "Building of documentation failed"
	fi
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r docs/_build/html/* || die "Installation of documentation failed"
	fi
}

src_test() {
	distutils_python_version
	cd tests
	"${python}" runtests.py || die "Tests failed."
}
