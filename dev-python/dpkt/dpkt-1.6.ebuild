# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dpkt/dpkt-1.6.ebuild,v 1.2 2007/06/23 07:24:31 lucass Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="Fast, simple packet creation / parsing, with definitions for the basic TCP/IP protocols."
HOMEPAGE="http://code.google.com/p/dpkt/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

src_install() {
	DOCS="HACKING AUTHORS CHANGES"
	distutils_src_install
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	PYTHONPATH=. "${python}" tests/test-perf2.py || die "tests failed"
}
