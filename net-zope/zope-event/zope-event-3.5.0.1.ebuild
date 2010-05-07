# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-event/zope-event-3.5.0.1.ebuild,v 1.1 2010/05/07 00:11:49 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
#MY_P="${MY_PN}-${PV}"
MY_P="${MY_PN}-${PV%.*}-${PV##*.}"

DESCRIPTION="Very basic event publishing system"
HOMEPAGE="http://pypi.python.org/pypi/zope.event"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="test"

DEPEND="dev-python/setuptools
	test? ( dev-python/nose )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="README.txt"
PYTHON_MODNAME="${PN/-//}"

src_test() {
	testing() {
		# Future versions of dev-python/nose will support Python 3.
		[[ "${PYTHON_ABI}" == 3.* ]] && return

		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	newdoc src/zope/event/README.txt event-README.txt
}
