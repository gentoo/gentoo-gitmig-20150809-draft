# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testoob/testoob-1.12.ebuild,v 1.3 2006/10/21 01:47:30 agriffis Exp $

inherit distutils eutils

DESCRIPTION="Advanced Python testing framework"
HOMEPAGE="http://testoob.sourceforge.net/"
SRC_URI="mirror://sourceforge/testoob/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ia64 ~sparc x86"
IUSE="pdf threads"

DEPEND="virtual/python"
RDEPEND="${DEPEND}
	dev-python/4suite
	pdf? ( dev-python/reportlab )
	threads? ( dev-python/twisted )"

DOCS="docs/*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e '1iimport warnings' -i tests/helpers.py
	sed -e '5d' -i setup.py
}

src_test() {
	distutils_python_version
	PATH="src/testoob:${PATH}" PYTHONPATH="src" \
		"${python}" tests/alltests.py || die "alltests.py failed"
}
