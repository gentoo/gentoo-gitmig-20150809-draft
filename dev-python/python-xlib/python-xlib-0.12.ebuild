# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-xlib/python-xlib-0.12.ebuild,v 1.5 2003/06/22 12:16:00 liquidx Exp $

inherit distutils

S=${WORKDIR}/${P}
DESCRIPTION="A fully functional X client library for Python, written in Python."
SRC_URI="mirror://sourceforge/python-xlib/${P}.tar.gz"
HOMEPAGE="http://python-xlib.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE=""

src_install () {
	mydoc="doc/ps/python-xlib.ps PKG-INFO TODO"
	distutils_src_install
	dohtml -r doc/html/
	doinfo doc/info/*.info*
}
