# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wtforms/wtforms-0.4.ebuild,v 1.4 2009/12/02 10:49:11 maekke Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="WTForms"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Flexible forms validation and rendering library for python web development"
HOMEPAGE="http://wtforms.simplecodes.com/ http://pypi.python.org/pypi/WTForms"
SRC_URI="http://pypi.python.org/packages/source/W/${MY_PN}/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

S="${WORKDIR}/${MY_P}"

DEPEND="doc? ( >=dev-python/sphinx-0.6 )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="AUTHORS.txt CHANGES.txt INSTALL.txt LICENSE.txt README.txt"

src_compile() {
	distutils_src_compile
	if use doc; then
		cd docs
		PYTHONPATH=.. emake html || die "Building of documentation failed"
	fi
}

src_test() {
	cd tests
	testing() {
		"$(PYTHON)" runtests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r docs/_build/html/* || die "Installation of documentation failed"
	fi
}
