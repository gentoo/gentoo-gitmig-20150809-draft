# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chaco/chaco-3.3.0.ebuild,v 1.2 2010/04/23 05:57:59 bicatali Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils virtualx

MY_PN="Chaco"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Interactive plotting toolkit"
HOMEPAGE="http://code.enthought.com/projects/chaco"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/enable-3.3.0"
DEPEND="dev-python/setuptools
	dev-python/numpy
	doc? ( dev-python/setupdocs )
	test? ( >=dev-python/nose-0.10.3
			dev-python/coverage
			>=dev-python/enable-3.3.0
			>=dev-python/enthoughtbase-3.0.4
			x11-apps/xhost
			media-fonts/font-misc-misc
			media-fonts/font-cursor-misc )"

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "s/setupdocs>=1.0//" \
		setup.py || die
	sed -i -e 's:enthought/chaco2/tests::' setup.cfg || die
}

src_compile() {
	distutils_src_compile
	if use doc; then
		"$(PYTHON -f)" setup.py build_docs --formats=html,pdf || die "Generation of documentation failed"
	fi
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	export maketype="python_execute_function"
	virtualmake testing
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	dodoc docs/*.txt
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/docs/html build/docs/latex/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
