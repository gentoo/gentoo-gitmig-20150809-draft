# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chaco/chaco-3.1.0.ebuild,v 1.1 2009/03/27 10:44:41 bicatali Exp $

EAPI=2
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

RDEPEND=">=dev-python/enable-3.1.0"
DEPEND="dev-python/setuptools
	>=dev-python/numpy-1.1
	doc? ( app-arch/unzip )"
# docs building and tests need an X display
#	doc? ( dev-python/setupdocs )
#	test? ( >=dev-python/nose-0.10.3
#			dev-python/coverage
#			>=dev-python/enable-3.1.0
#			>=dev-python/enthoughtbase-3.0.2 )"

RESTRICT=test
S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
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
	"${python}" setup.py test || die "tests failed"
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
