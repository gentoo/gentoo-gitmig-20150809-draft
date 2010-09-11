# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/acquisition/acquisition-2.13.4.ebuild,v 1.1 2010/09/11 21:28:09 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Acquisition"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Acquisition is a mechanism that allows objects to obtain attributes from the containment hierarchy they're in."
HOMEPAGE="http://pypi.python.org/pypi/Acquisition"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/extensionclass
	net-zope/zope-interface"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="CHANGES.txt src/Acquisition/README.txt"
PYTHON_MODNAME="${MY_PN}"

distutils_src_test_pre_hook() {
	local module
	for module in Acquisition; do
		ln -fs "../../$(ls -d build-${PYTHON_ABI}/lib.*)/${module}/_${module}.so" "src/${module}/_${module}.so" || die "Symlinking ${module}/_${module}.so failed with Python ${PYTHON_ABI}"
	done
}

src_install() {
	distutils_src_install
	python_clean_installation_image
}
