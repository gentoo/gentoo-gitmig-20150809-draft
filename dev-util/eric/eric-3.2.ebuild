# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-3.2.ebuild,v 1.3 2004/01/11 21:31:15 pythonhead Exp $

IUSE=""
DESCRIPTION="The eric3 Python IDE"
HOMEPAGE="http://www.die-offenbachs.de/detlev/eric3.html"
SRC_URI="http://www.die-offenbachs.de/detlev/files/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc
	sys-devel/libtool
	>=x11-libs/qt-3.0.4.1
	>=dev-python/qscintilla-1.52
	>=dev-lang/python-2.2.1
	>=dev-python/sip-3.6
	<=dev-python/PyQt-3.8.1"

src_install() {
	python install.py \
		-b /usr/bin \
		-i ${D}
	dodoc HISTORY LICENSE.GPL README THANKS
}
