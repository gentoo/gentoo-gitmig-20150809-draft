# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-3.1.ebuild,v 1.1 2003/04/29 17:55:28 brain Exp $

IUSE=""
DESCRIPTION="The eric3 Python IDE"
SRC_URI="http://www.die-offenbachs.de/detlev/files/${P}.tar.gz"
HOMEPAGE="http://www.die-offenbachs.de/detlev/eric3.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="virtual/glibc
	sys-devel/libtool
	>=x11-libs/qt-3.0.4.1
	>=dev-python/qscintilla-1.52
	>=dev-lang/python-2.2.1
	>=dev-python/sip-3.6
	>=dev-python/PyQt-3.6-r1"

src_install() {
	python install.py \
		-b /usr/bin \
		-i ${D}
	dodoc HISTORY LICENSE.GPL README THANKS
}
