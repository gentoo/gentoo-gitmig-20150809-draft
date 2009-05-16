# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dpkt/dpkt-1.6.ebuild,v 1.3 2009/05/16 21:22:18 arfrever Exp $

EAPI="2"

NEED_PYTHON="2.3"

inherit distutils eutils

DESCRIPTION="Fast, simple packet creation / parsing, with definitions for the basic TCP/IP protocols."
HOMEPAGE="http://code.google.com/p/dpkt/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-python-2.6.patch"
}

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
