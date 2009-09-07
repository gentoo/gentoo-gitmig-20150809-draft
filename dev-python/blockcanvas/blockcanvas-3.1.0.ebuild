# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blockcanvas/blockcanvas-3.1.0.ebuild,v 1.1 2009/09/07 06:12:11 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="BlockCanvas"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tool Suite numerical modeling framework"
HOMEPAGE="http://code.enthought.com/projects/block_canvas.php"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE=""
#IUSE="test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/numpy-1.1
	dev-python/configobj
	dev-python/docutils
	>=dev-python/apptools-3.3.0
	>=dev-python/chaco-3.2.0
	>=dev-python/enthoughtbase-3.0.3
	>=dev-python/etsdevtools-3.0.3
	>=dev-python/scimath-3.0.4
	>=dev-python/traitsgui-3.1.0
	dev-python/imaging"
DEPEND="dev-python/setuptools"
# Tests require X display.
#	test? ( ${RDEPEND} >=dev-python/nose-0.10.3 )
RESTRICT_PYTHON_ABIS="3.*"
RESTRICT="test"

S="${WORKDIR}/${MY_P}"
PYTHON_MODNAME="enthought"

src_prepare() {
	sed -e "s/self.run_command('build_docs')/pass/" -i setup.py || die
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
}
