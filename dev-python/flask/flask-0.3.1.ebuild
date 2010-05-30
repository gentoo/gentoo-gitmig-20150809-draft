# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask/flask-0.3.1.ebuild,v 1.1 2010/05/30 11:00:08 djc Exp $

EAPI=3
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="Flask"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A microframework based on Werkzeug, Jinja2 and good intentions"
HOMEPAGE="http://pypi.python.org/pypi/Flask/"
SRC_URI="http://pypi.python.org/packages/source/F/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="
	dev-python/setuptools
	>=dev-python/jinja-2.4
	>=dev-python/werkzeug-0.6.1"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.6 )"

S=${WORKDIR}/${MY_P}

src_compile() {
	distutils_src_compile

	if use doc; then
		cd docs && einfo "Generation of documentation"
		PYTHONPATH=".." emake html || die "Building of documentation failed"
	fi
}

src_install() {
	distutils_src_install
	python_clean_installation_image

	if use doc; then
		dohtml -r docs/_build/html/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto "/usr/share/doc/${PF}"
		doins -r examples || die "Failed to install examples"
	fi
}

src_test() {
	testing() {
		PYTHONPATH=. "$(PYTHON)" tests/flask_tests.py
	}
	python_execute_function testing
}
