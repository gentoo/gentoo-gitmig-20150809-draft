# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/extensionclass/extensionclass-2.11.3.ebuild,v 1.1 2009/12/05 03:07:20 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="ExtensionClass"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Metaclass for subclassable extension types"
HOMEPAGE="http://pypi.python.org/pypi/ExtensionClass"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="test? ( dev-python/nose )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="ComputedAttribute ExtensionClass MethodObject"
DOCS="CHANGES.txt README.txt"

src_test() {
	testing() {
		local module
		for module in ComputedAttribute ExtensionClass MethodObject; do
			ln -fs "../../$(ls -d build-${PYTHON_ABI}/lib.*)/${module}/_${module}.so" "src/${module}/_${module}.so" || die "Symlinking ${module}/_${module}.so failed with Python ${PYTHON_ABI}"
		done

		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	# Don't install sources.
	find "${D}"usr/$(get_libdir)/python*/site-packages -name "*.c" -o -name "*.h" | xargs rm -f
}
