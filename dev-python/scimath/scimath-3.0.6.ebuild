# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scimath/scimath-3.0.6.ebuild,v 1.1 2010/10/18 13:50:52 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="SciMath"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite scientific and mathematical tools"
HOMEPAGE="http://code.enthought.com/projects/sci_math.php http://pypi.python.org/pypi/SciMath"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/enthoughtbase-3.0.6
	>=dev-python/numpy-1.1
	>=dev-python/traits-3.5.0
	sci-libs/scipy"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( >=dev-python/nose-0.10.3
			>=dev-python/etsdevtools-3.1.0
			>=dev-python/traitsgui-3.5.0[wxwidgets] )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare

	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"
}
