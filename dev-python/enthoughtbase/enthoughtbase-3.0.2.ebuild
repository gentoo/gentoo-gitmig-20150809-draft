# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enthoughtbase/enthoughtbase-3.0.2.ebuild,v 1.2 2009/07/01 07:55:29 lordvan Exp $

EAPI=2
inherit distutils

MY_PN="EnthoughtBase"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Core packages for the Enthought Tool Suite"
HOMEPAGE="http://code.enthought.com/projects/enthought_base.php"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD LGPL-2"
RDEPEND=""
DEPEND="dev-python/setuptools
	doc? ( dev-python/setupdocs )"
# tests would require circular deps
#	test? ( >=dev-python/nose-0.10.3
#			dev-python/traits
#			dev-python/etsdevtools )"
RESTRICT=test

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
}

src_compile() {
	distutils_src_compile
	if use doc; then
		export VARTEXFONTS="${T}/fonts"
		${python} setup.py build_docs --formats=html,pdf \
			|| die "doc building failed"
	fi
}

src_test() {
	PYTHONPATH=build/lib "${python}" setup.py test || die "tests failed"
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	dodoc docs/*.txt
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/docs/html || die
		# no pdf docs there...
		#doins build/docs/latex/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
