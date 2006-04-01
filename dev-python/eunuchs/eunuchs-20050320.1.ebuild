# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eunuchs/eunuchs-20050320.1.ebuild,v 1.2 2006/04/01 14:52:23 agriffis Exp $

inherit distutils

DESCRIPTION="Missing manly parts of UNIX API for Python"
HOMEPAGE="http://www.inoi.fi/open/trac/eunuchs"
SRC_URI="mirror://debian/pool/main/e/${PN}/${PN}_${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""

DEPEND="dev-lang/python"

src_install() {
	distutils_src_install

	docinto examples
	dodoc examples/*
}

src_test() {
	${python} examples/test-socketpair.py || die "socketpair test failed"
}
