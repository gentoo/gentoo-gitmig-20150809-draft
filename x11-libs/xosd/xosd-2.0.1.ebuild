# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xosd/xosd-2.0.1.ebuild,v 1.1 2002/12/19 18:06:13 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Library for overlaying text/glyphs in X-Windows \
X-On-Screen-Display plus binary for sending text from command line."
HOMEPAGE="http://www.ignavus.net/"
SRC_URI="http://www.ignavus.net/${P}.tar.gz"

IUSE=""
DEPEND="virtual/x11"
RDEPEND=${DEPEND}
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc "

src_install () {
	insinto /usr/include
	doins src/xosd.h
	into /usr
	dolib.a src/libxosd/.libs/libxosd.a
	dolib.so src/libxosd/.libs/libxosd.so.2
	dobin src/.libs/osd_cat
	dobin script/xosd-config
	doman man/*.1 man/*.3
	dodoc AUTHORS ChangeLog NEWS COPYING README
}
