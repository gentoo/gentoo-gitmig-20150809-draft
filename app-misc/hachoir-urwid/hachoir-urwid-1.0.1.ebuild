# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hachoir-urwid/hachoir-urwid-1.0.1.ebuild,v 1.3 2009/08/15 13:08:51 ssuominen Exp $

EAPI=2
inherit distutils

DESCRIPTION="user interface based on hachoir-parser to explore a binary file"
HOMEPAGE="http://hachoir.org/wiki/hachoir-urwid"
SRC_URI="http://cheeseshop.python.org/packages/source/h/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4[ncurses]"
RDEPEND="${DEPEND}
	>=dev-python/hachoir-core-1.0.1
	>=dev-python/hachoir-parser-1.0
	>=dev-python/urwid-0.9.4"

PYTHON_MODNAME="hachoir_urwid"
