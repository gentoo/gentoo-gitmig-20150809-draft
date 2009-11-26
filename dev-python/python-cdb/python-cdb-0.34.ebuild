# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-cdb/python-cdb-0.34.ebuild,v 1.6 2009/11/26 17:34:27 maekke Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="A Python extension module for cdb"
SRC_URI="http://pilcrow.madison.wi.us/python-cdb/${P}.tar.gz"
HOMEPAGE="http://pilcrow.madison.wi.us/#pycdb"

SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="amd64 arm ~ia64 ppc sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"

DEPEND="dev-db/cdb"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="Example"

src_test() {
	testing() {
		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" install --home "${T}/test-${PYTHON_ABI}"
		# This is not really intended as test but it is better than nothing.
		PYTHONPATH="${T}/test-${PYTHON_ABI}/lib/python" "$(PYTHON)" < Example
	}
	python_execute_function testing
}
