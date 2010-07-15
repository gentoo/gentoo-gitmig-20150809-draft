# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enthoughtbase/enthoughtbase-3.0.5.ebuild,v 1.4 2010/07/15 11:47:29 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="EnthoughtBase"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Core packages for the Enthought Tool Suite"
HOMEPAGE="http://code.enthought.com/projects/enthought_base.php http://pypi.python.org/pypi/EnthoughtBase"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="doc examples"

DEPEND="dev-python/setuptools
	doc? ( dev-python/setupdocs )"
# tests would require circular deps
#	test? ( >=dev-python/nose-0.10.3
#			dev-python/traits
#			dev-python/etsdevtools )"
RDEPEND=""

RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare

	sed -i \
		-e "s/self.run_command('build_docs')/pass/" \
		-e '/setupdocs/d' \
		setup.py || die
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		export VARTEXFONTS="${T}/fonts"
		"$(PYTHON -f)" setup.py build_docs --formats=html,pdf || die "Generation of documentation failed"
	fi
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	dodoc docs/*.txt
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/docs/html || die
		doins build/docs/latex/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
