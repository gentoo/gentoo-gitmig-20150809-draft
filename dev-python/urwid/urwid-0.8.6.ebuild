# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/urwid/urwid-0.8.6.ebuild,v 1.2 2005/01/21 04:32:48 pythonhead Exp $

inherit distutils

DESCRIPTION="urwid is a curses-based user interface library for Python."
HOMEPAGE="http://excess.org/urwid/"
SRC_URI="http://excess.org/urwid/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=dev-lang/python-2.1.3-r1"
DOCS="browse.py edit.py test_urwid.py calc.py fib.py tour.py"

src_install() {
	distutils_src_install
	dohtml *html
}
