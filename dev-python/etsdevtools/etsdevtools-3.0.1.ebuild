# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/etsdevtools/etsdevtools-3.0.1.ebuild,v 1.1 2009/01/15 10:27:10 bicatali Exp $

EAPI=2
inherit distutils

MY_PN="ETSDevTools"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tool Suite to support Python development"
HOMEPAGE="http://code.enthought.com/projects/ets_dev_tools.php"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

IUSE="doc examples test wxwindows"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/numpy-1.1
	dev-python/docutils
	dev-python/celementtree
	dev-python/elementtree
	dev-python/traitsgui
	dev-python/nose
	dev-python/pyro
	dev-python/reportlab
	dev-python/testoob
	x11-libs/libXtst
	wxwindows? ( dev-python/wxpython )"

DEPEND="dev-python/setuptools
	>=dev-python/numpy-1.1
	x11-libs/libXtst
	test? ( >=dev-python/nose-0.10.3 )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
}

src_test() {
	PYTHONPATH=$(dir -d build/lib*) ${python} setup.py test || die "tests failed"
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
