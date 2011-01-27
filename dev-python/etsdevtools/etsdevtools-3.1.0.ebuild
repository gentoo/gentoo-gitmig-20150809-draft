# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/etsdevtools/etsdevtools-3.1.0.ebuild,v 1.6 2011/01/27 10:00:52 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit distutils

MY_PN="ETSDevTools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought tools to support Python development"
HOMEPAGE="http://code.enthought.com/projects/ets_dev_tools.php http://pypi.python.org/pypi/ETSDevTools"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples wxwidgets"
SLOT="0"
KEYWORDS="amd64 ppc x86"
LICENSE="BSD"

DEPEND="dev-python/docutils
	>=dev-python/nose-0.10.3
	dev-python/numpy
	dev-python/setuptools
	>=dev-python/traitsgui-3.5.0
	wxwidgets? ( dev-python/wxpython:2.8 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare

	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"
}

src_install() {
	find "${S}" -name "*LICENSE.txt" -delete
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r docs/*/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
