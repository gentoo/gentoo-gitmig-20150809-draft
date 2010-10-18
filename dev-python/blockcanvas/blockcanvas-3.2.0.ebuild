# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blockcanvas/blockcanvas-3.2.0.ebuild,v 1.1 2010/10/18 15:19:01 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils virtualx

MY_PN="BlockCanvas"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite numerical modeling framework"
HOMEPAGE="http://code.enthought.com/projects/block_canvas.php http://pypi.python.org/pypi/BlockCanvas"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/numpy
	dev-python/configobj
	dev-python/docutils
	>=dev-python/apptools-3.4.0
	>=dev-python/chaco-3.3.2
	>=dev-python/enthoughtbase-3.0.6
	>=dev-python/etsdevtools-3.1.0
	dev-python/greenlet
	>=dev-python/scimath-3.0.5
	>=dev-python/traitsgui-3.5.0
	dev-python/imaging"
DEPEND="dev-python/setuptools
	test? (
		dev-python/coverage
		>=dev-python/nose-0.10.3
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		x11-apps/xhost
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare

	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"
}

src_test() {
	maketype="distutils_src_test" virtualmake
}

src_install() {
	find "${S}" -name "*LICENSE.txt" -delete
	distutils_src_install
	dodoc docs/*.txt
}
