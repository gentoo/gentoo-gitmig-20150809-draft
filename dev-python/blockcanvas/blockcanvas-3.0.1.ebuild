# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blockcanvas/blockcanvas-3.0.1.ebuild,v 1.2 2009/01/15 11:19:47 bicatali Exp $

EAPI=2
inherit distutils

MY_PN="BlockCanvas"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tool Suite numerical modeling framework"
HOMEPAGE="http://code.enthought.com/projects/block_canvas.php"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

IUSE="test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/numpy-1.1
	dev-python/apptools
	dev-python/chaco
	dev-python/configobj
	dev-python/docutils
	dev-python/enthoughtbase
	dev-python/etsdevtools
	dev-python/scimath
	dev-python/imaging
	dev-python/traitsgui"

DEPEND="dev-python/setuptools
	test? ( ${RDEPEND} >=dev-python/nose-0.10.3 )"

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
	dodoc docs/*.txt
}
