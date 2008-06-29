# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sphinx/sphinx-0.3.ebuild,v 1.4 2008/06/29 09:42:36 armin76 Exp $

inherit distutils

MY_PN="Sphinx"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A tool that makes it easy to create intelligent and beautiful documentation for Python projects."
HOMEPAGE="http://sphinx.pocoo.org/"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-python/pygments-0.8
	>=dev-python/jinja-1.1
	>=dev-python/docutils-0.4
	dev-python/setuptools"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	DOCS="CHANGES"
	distutils_src_compile

	if use doc ; then
		cd doc
		PYTHONPATH="../" emake SPHINXBUILD="${python} ../sphinx-build.py" html || die "making docs failed"
	fi
}

src_install() {
	distutils_src_install
	if use doc ; then
		dohtml -A txt -r doc/_build/html/*
	fi
}
