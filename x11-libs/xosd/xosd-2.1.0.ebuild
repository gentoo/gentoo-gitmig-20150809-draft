# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xosd/xosd-2.1.0.ebuild,v 1.4 2003/08/15 11:08:37 lanius Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Library for overlaying text/glyphs in X-Windows \
X-On-Screen-Display plus binary for sending text from command line."
HOMEPAGE="http://www.ignavus.net/"
SRC_URI="http://www.ignavus.net/${P}.tar.gz"

IUSE="xmms"
DEPEND="virtual/x11
	xmms? ( media-sound/xmms
		media-libs/gdk-pixbuf )"
RDEPEND=${DEPEND}
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc"

src_compile() {
	local myconf

	if [ "`use xmms`" ]; then
		myconf="--with-plugindir=/usr/lib/xmms"
	else
		myconf="--without-plugindir"
	fi

	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS COPYING README
}
