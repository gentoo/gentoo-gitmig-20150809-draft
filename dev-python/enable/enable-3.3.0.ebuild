# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enable/enable-3.3.0.ebuild,v 1.1 2010/03/23 05:10:59 bicatali Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_PN="Enable"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tool Suite drawing and interaction GUI objects"
HOMEPAGE="http://code.enthought.com/projects/enable"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="examples"
#IUSE="examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-python/numpy
	dev-python/reportlab
	>=dev-python/traitsgui-3.3.0
	>=media-libs/freetype-2
	virtual/glu
	x11-libs/libX11"

DEPEND="dev-python/setuptools
	dev-python/numpy
	>=media-libs/freetype-2
	virtual/glu
	x11-libs/libX11
	dev-lang/swig
	dev-python/pyrex"
RESTRICT_PYTHON_ABIS="3.*"
# tests need X with wxpython
#	test? ( >=dev-python/nose-0.10.3
#			>=dev-python/enthoughtbase-3.0.4
#			>=dev-python/traitsgui[wxwindows]-3.3.0 )"
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

DOCS="CHANGELOG.txt"

src_prepare() {
	epatch "${FILESDIR}/${PN}-3.0.2-nofreetype.patch"
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
}

src_test() {
	testing() {
		PYTHONPATH="$(dir -d build-${PYTHON_ABI}/lib*)" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die
	fi
}
