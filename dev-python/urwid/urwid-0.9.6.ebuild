# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/urwid/urwid-0.9.6.ebuild,v 1.1 2006/08/23 18:57:43 lucass Exp $

inherit distutils eutils

DESCRIPTION="Urwid is a curses-based user interface library for Python."
HOMEPAGE="http://excess.org/urwid/"
SRC_URI="http://excess.org/urwid/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"

IUSE="examples"
DEPEND="virtual/python"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-nosetuptools.diff"
}

src_test() {
	${python} test_urwid.py || die "unit tests failed"
}

src_install() {
	distutils_src_install

	dohtml tutorial.html reference.html
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins browse.py calc.py dialog.py edit.py
		doins fib.py graph.py input_test.py tour.py
	fi
}
