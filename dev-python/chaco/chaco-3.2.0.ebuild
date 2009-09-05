# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chaco/chaco-3.2.0.ebuild,v 1.1 2009/09/05 23:23:12 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="Chaco"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Interactive plotting toolkit"
HOMEPAGE="http://code.enthought.com/projects/chaco"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/enable-3.2.0"
DEPEND="dev-python/setuptools
	>=dev-python/numpy-1.1
	doc? ( app-arch/unzip )"
# docs building and tests need an X display
#	doc? ( dev-python/setupdocs )
#	test? ( >=dev-python/nose-0.10.3
#			dev-python/coverage
#			>=dev-python/enable-3.2.0
#			>=dev-python/enthoughtbase-3.0.3 )"
RESTRICT_PYTHON_ABIS="3.*"
#RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "s/self.run_command('build_docs')/pass/" setup.py || die
}

src_compile() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_compile
	#if use doc; then
	#	${python} setup.py build_docs --formats=html,pdf \
	#		|| die "doc building failed"
	#fi
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	dodoc docs/*.txt
	insinto /usr/share/doc/${PF}
	if use doc; then
		#doins -r build/docs/html build/docs/latex/*.pdf || die
		doins docs/*.pdf || die
		unzip docs/html.zip
		insinto /usr/share/doc/${PF}
		doins -r html || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
