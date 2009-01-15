# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enable/enable-3.0.2.ebuild,v 1.1 2009/01/15 10:24:27 bicatali Exp $

EAPI=2
inherit eutils distutils

MY_PN="Enable"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tools Suite drawing and interaction GUI objects"
HOMEPAGE="http://code.enthought.com/projects/enable"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

IUSE="examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/numpy-1.1
	dev-python/reportlab
	dev-python/traitsgui
	>=media-libs/freetype-2
	virtual/glu
	x11-libs/libX11"

DEPEND="dev-python/setuptools
	>=dev-python/numpy-1.1
	>=media-libs/freetype-2
	virtual/glu
	x11-libs/libX11
	dev-lang/swig
	dev-python/pyrex
	test? ( >=dev-python/nose-0.10.3
			dev-python/enthoughtbase
			dev-python/traitsgui[wxwindows] )"

#tests need X
RESTRICT=test

S="${WORKDIR}/${MY_P}"
PYTHON_MODNAME="enthought"

src_prepare() {
	epatch "${FILESDIR}"/${P}-nofreetype.patch
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
}

src_test() {
	PYTHONPATH=$(dir -d build/lib*) ${python} setup.py test || die "tests failed"
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die
	fi
}
