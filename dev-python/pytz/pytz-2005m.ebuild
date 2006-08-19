# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytz/pytz-2005m.ebuild,v 1.6 2006/08/19 19:45:11 dertobi123 Exp $

inherit distutils

DESCRIPTION="World Timezone Definitions for Python"
HOMEPAGE="http://pytz.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	!<=dev-python/matplotlib-0.82"

DOCS="CHANGES.txt"

src_test() {
	PYTHONPATH=. ${python} pytz/tests/test_tzinfo.py || die "test failed"
}
