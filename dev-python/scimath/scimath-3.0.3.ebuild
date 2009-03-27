# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scimath/scimath-3.0.3.ebuild,v 1.1 2009/03/27 10:53:43 bicatali Exp $

EAPI=2
inherit distutils

MY_PN="SciMath"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tool Suite scientific and mathematical tools"
HOMEPAGE="http://code.enthought.com/projects/sci_math.php"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/numpy-1.1
	sci-libs/scipy
	>=dev-python/traits-3.1"

DEPEND="dev-python/setuptools
	>=dev-python/numpy-1.1
	test? ( >=dev-python/nose-0.10.3
			>=dev-python/enthoughtbase-3.0.2
			>=dev-python/traitsgui-3.0.4[wxwindows]
			sci-libs/scipy )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
}

src_test() {
	PYTHONPATH=$(dir -d build/lib*) "${python}" setup.py test || die "tests failed"
}
