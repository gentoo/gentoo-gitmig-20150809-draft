# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/envisagecore/envisagecore-3.1.2.ebuild,v 1.3 2010/07/07 01:00:16 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="EnvisageCore"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite extensible application framework"
HOMEPAGE="http://code.enthought.com/projects/envisage/ http://pypi.python.org/pypi/EnvisageCore"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/apptools-3.3.1
	>=dev-python/traits-3.3.0
	>=dev-python/enthoughtbase-3.0.4"
DEPEND="dev-python/setuptools
	doc? ( dev-python/setupdocs )
	test? ( >=dev-python/nose-0.10.3
			>=dev-python/apptools-3.3.1
			>=dev-python/enthoughtbase-3.0.4 )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "s/setupdocs>=1.0//" \
		setup.py || die
}

src_compile() {
	distutils_src_compile
	if use doc; then
		"$(PYTHON -f)" setup.py build_docs --formats=html,pdf || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/docs/html || die
		doins build/docs/latex/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
