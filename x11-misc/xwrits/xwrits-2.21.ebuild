# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xwrits/xwrits-2.21.ebuild,v 1.7 2004/04/11 17:51:49 pyrania Exp $

DESCRIPTION="Xwrits reminds you to take wrist breaks, which will hopefully help you prevent repetitive stress injury. It pops up an X window when you should rest; you click on that window, then take a break"
HOMEPAGE="http://www.lcdf.org/xwrits/"
SRC_URI="http://www.lcdf.org/xwrits/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="x11-base/xfree"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc GESTURES NEWS README
}
