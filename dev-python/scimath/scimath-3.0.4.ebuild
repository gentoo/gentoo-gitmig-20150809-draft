# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scimath/scimath-3.0.4.ebuild,v 1.1 2009/09/05 23:57:00 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

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
	>=dev-python/traits-3.2.0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( >=dev-python/nose-0.10.3
			>=dev-python/enthoughtbase-3.0.3
			>=dev-python/traitsgui-3.1.0[wxwidgets] )"
RESTRICT_PYTHON_ABIS="3.*"

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
