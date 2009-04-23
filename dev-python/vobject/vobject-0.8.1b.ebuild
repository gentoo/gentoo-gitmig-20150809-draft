# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vobject/vobject-0.8.1b.ebuild,v 1.2 2009/04/23 19:17:50 maekke Exp $

NEED_PYTHON="2.4"

inherit distutils

DESCRIPTION="A full featured Python package for parsing and generating vCard and vCalendar files"
HOMEPAGE="http://vobject.skyhouseconsulting.com/"
SRC_URI="http://vobject.skyhouseconsulting.com/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-python/python-dateutil-1.1"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="ACKNOWLEDGEMENTS.txt"

src_test() {
	PYTHONPATH="${S}/src" "${python}" test_vobject.py || die "tests failed"
}
