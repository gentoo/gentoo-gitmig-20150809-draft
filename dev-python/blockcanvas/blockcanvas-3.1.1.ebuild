# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blockcanvas/blockcanvas-3.1.1.ebuild,v 1.2 2010/07/07 03:58:39 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="BlockCanvas"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite numerical modeling framework"
HOMEPAGE="http://code.enthought.com/projects/block_canvas.php http://pypi.python.org/pypi/BlockCanvas"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#IUSE="test"

RDEPEND="dev-python/numpy
	dev-python/configobj
	dev-python/docutils
	>=dev-python/apptools-3.3.1
	>=dev-python/chaco-3.3.0
	>=dev-python/enthoughtbase-3.0.4
	>=dev-python/etsdevtools-3.0.4
	>=dev-python/scimath-3.0.5
	>=dev-python/traitsgui-3.3.0
	dev-python/imaging"
DEPEND="dev-python/setuptools"
# Tests require X display.
#	test? ( ${RDEPEND} >=dev-python/nose-0.10.3 )
RESTRICT="test"

S="${WORKDIR}/${MY_P}"
PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "s/setupdocs>=1.0//" \
		setup.py || die
}

src_install() {
	find "${S}" -name "*LICENSE.txt" -delete
	distutils_src_install
	dodoc docs/*.txt
}
