# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-xlib/python-xlib-0.12-r2.ebuild,v 1.1 2006/02/08 20:58:35 lucass Exp $

inherit distutils eutils

DESCRIPTION="A fully functional X client library for Python, written in Python"
HOMEPAGE="http://python-xlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/python-xlib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~ia64 ~amd64"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-buflen.patch
}

src_install () {
	epatch ${FILESDIR}/${P}-info.patch
	mydoc="doc/ps/python-xlib.ps PKG-INFO TODO"
	distutils_src_install
	dohtml -r doc/html/
	doinfo doc/info/*.info*
}
