# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xwrits/xwrits-2.21.ebuild,v 1.1 2002/05/11 06:59:29 agenkin Exp $

DESCRIPTION="Xwrits reminds you to take wrist breaks, which will hopefully help you prevent repetitive stress injury. It pops up an X window when you should rest; you click on that window, then take a break"
HOMEPAGE="http://www.lcdf.org/xwrits/"

SRC_URI="http://www.lcdf.org/xwrits/${P}.tar.gz"
S=${WORKDIR}/${P}

DEPEND="x11-base/xfree"

src_compile() {

	./configure --prefix=/usr                 \
			--host=${CHOST}           \
			--mandir=/usr/share/man	  \
			--infodir=/usr/share/info \
			|| die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc GESTURES NEWS README
}
