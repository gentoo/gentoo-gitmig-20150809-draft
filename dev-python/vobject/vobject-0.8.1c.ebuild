# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vobject/vobject-0.8.1c.ebuild,v 1.3 2010/07/06 21:04:23 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A full featured Python package for parsing and generating vCard and vCalendar files"
HOMEPAGE="http://vobject.skyhouseconsulting.com/ http://pypi.python.org/pypi/vobject"
SRC_URI="http://vobject.skyhouseconsulting.com/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/python-dateutil-1.1"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="ACKNOWLEDGEMENTS.txt"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test_vobject.py
	}
	python_execute_function testing
}
