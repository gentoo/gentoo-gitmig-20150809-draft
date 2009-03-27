# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blockcanvas/blockcanvas-3.0.2.ebuild,v 1.1 2009/03/27 10:46:41 bicatali Exp $

EAPI=2
inherit distutils

MY_PN="BlockCanvas"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tool Suite numerical modeling framework"
HOMEPAGE="http://code.enthought.com/projects/block_canvas.php"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/numpy-1.1
	dev-python/configobj
	dev-python/docutils
	>=dev-python/apptools-3.2
	>=dev-python/chaco-3.1
	>=dev-python/enthoughtbase-3.0.2
	>=dev-python/etsdevtools-3.0.2
	>=dev-python/scimath-3.0.3
	>=dev-python/traitsgui-3.0.4
	dev-python/imaging"

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
