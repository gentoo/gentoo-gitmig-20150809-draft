# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/icalendar/icalendar-2.1-r1.ebuild,v 1.6 2010/12/26 14:43:52 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

DESCRIPTION="Package used for parsing and generating iCalendar files (RFC 2445)."
HOMEPAGE="http://codespeak.net/icalendar/ http://pypi.python.org/pypi/icalendar"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.txt CREDITS.txt doc/* HISTORY.txt README.txt TODO.txt"

src_prepare() {
	epatch "${FILESDIR}/2.1_p20100409/01_all_UIDGenerator-fix.patch"
	epatch "${FILESDIR}/2.1_p20100409/02_all_vDatetime-tzinfo-fix.patch"
}

src_test() {
	testing() {
		"$(PYTHON)" test.py
	}
	python_execute_function testing
}
