# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hachoir-urwid/hachoir-urwid-1.0.1.ebuild,v 1.1 2007/07/14 13:28:01 cedk Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="user interface based on hachoir-parser to explore a binary file"
HOMEPAGE="http://hachoir.org/wiki/hachoir-urwid"
SRC_URI="http://cheeseshop.python.org/packages/source/h/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/hachoir-core-1.0.1
	>=dev-python/hachoir-parser-1.0
	>=dev-python/urwid-0.9.4"

PYTHON_MODNAME="hachoir_urwid"

pkg_setup() {
	if ! built_with_use virtual/python ncurses; then
		eerror "virtual/python must be build with ncurses"
		die "${PN} requires virtual/python with USE=ncurses"
	fi
}
