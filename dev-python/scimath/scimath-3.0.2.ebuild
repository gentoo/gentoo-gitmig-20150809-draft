# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scimath/scimath-3.0.2.ebuild,v 1.1 2009/01/15 10:29:32 bicatali Exp $

EAPI=2
inherit distutils

MY_PN="SciMath"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tool Suite scientific and mathematical tools"
HOMEPAGE="http://code.enthought.com/projects/sci_math.php"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

IUSE="test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/numpy-1.1
	sci-libs/scipy
	dev-python/traits"

DEPEND="dev-python/setuptools
	>=dev-python/numpy-1.1
	test? ( >=dev-python/nose-0.10.3 dev-python/enthoughtbase sci-libs/scipy )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
}

src_test() {
	PYTHONPATH=$(dir -d build/lib*) ${python} setup.py test || die "tests failed"
}
