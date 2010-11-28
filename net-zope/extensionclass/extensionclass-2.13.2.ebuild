# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/extensionclass/extensionclass-2.13.2.ebuild,v 1.3 2010/11/28 22:10:16 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils flag-o-matic

MY_PN="ExtensionClass"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Metaclass for subclassable extension types"
HOMEPAGE="http://pypi.python.org/pypi/ExtensionClass"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="ComputedAttribute ExtensionClass MethodObject"

src_compile() {
	append-flags -fno-strict-aliasing
	distutils_src_compile
}

distutils_src_test_pre_hook() {
	local module
	for module in ComputedAttribute ExtensionClass MethodObject; do
		ln -fs "../../$(ls -d build-${PYTHON_ABI}/lib.*)/${module}/_${module}.so" "src/${module}/_${module}.so" || die "Symlinking ${module}/_${module}.so failed with Python ${PYTHON_ABI}"
	done
}

src_install() {
	distutils_src_install
	python_clean_installation_image
}
