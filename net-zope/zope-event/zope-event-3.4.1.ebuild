# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-event/zope-event-3.4.1.ebuild,v 1.3 2009/11/09 18:57:31 fauli Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Very basic event publishing system"
HOMEPAGE="http://pypi.python.org/pypi/zope.event"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

DEPEND="dev-python/setuptools
	test? ( dev-python/nose )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN/-//}"
DOCS="README.txt"

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

	rm -f "${D}"usr/$(get_libdir)/python*/site-packages/zope/event/{README.txt,tests.py}
	newdoc src/zope/event/README.txt event-README.txt
}
