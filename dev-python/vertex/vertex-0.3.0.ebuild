# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vertex/vertex-0.3.0.ebuild,v 1.1 2009/11/30 14:07:40 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

# setup.py uses epsilon.setuphelper.autosetup(), which tries to use                                             
# build-${PYTHON_ABI} directories as packages.                                                                  
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit distutils

MY_PN="Vertex"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An implementation of the Q2Q protocol"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodVertex http://pypi.python.org/pypi/Vertex"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7
	>=dev-python/epsilon-0.5.0
	>=dev-python/pyopenssl-0.6
	>=dev-python/twisted-2.4"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

DOCS="NAME.txt README.txt"

src_compile() {
	# Skip distutils_src_compile to avoid installation of $(python_get_sitedir)/build directory.
	:
}

src_test() {
	testing() {
		PYTHONPATH="." trial vertex
	}
	python_execute_function testing
}
