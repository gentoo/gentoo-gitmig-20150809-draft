# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/icalendar/icalendar-2.0.1.ebuild,v 1.4 2010/02/08 08:48:54 pva Exp $

EAPI=2
inherit eutils distutils

DESCRIPTION="Package used for parsing and generating iCalendar files (RFC 2445)."
HOMEPAGE="http://codespeak.net/icalendar/ http://pypi.python.org/pypi/icalendar/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"

KEYWORDS="amd64 x86"

IUSE=""

DEPEND="=dev-lang/python-2*"
RDEPEND="${DEPEND}"

DOCS="CHANGES.txt CREDITS.txt doc/* HISTORY.txt README.txt TODO.txt"

src_prepare() {
	epatch "${FILESDIR}/${P}-UIDGenerator-fix.patch"
}

src_test() {
	"${python}" test.py || die
}
