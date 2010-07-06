# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/etsdevtools/etsdevtools-3.0.4.ebuild,v 1.3 2010/07/06 18:27:23 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="ETSDevTools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite to support Python development"
HOMEPAGE="http://code.enthought.com/projects/ets_dev_tools.php http://pypi.python.org/pypi/ETSDevTools"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples test wxwidgets"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-python/numpy
	dev-python/docutils
	>=dev-python/traitsgui-3.3.0
	>=dev-python/nose-0.10.3
	dev-python/pyro
	dev-python/reportlab
	dev-python/testoob
	x11-libs/libXtst
	wxwidgets? ( dev-python/wxpython:2.8 )"
DEPEND="dev-python/setuptools
	>=dev-python/numpy-1.1
	x11-libs/libXtst
	test? ( >=dev-python/nose-0.10.3 )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "s/setupdocs>=1.0//" \
		setup.py || die
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r docs/*/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
