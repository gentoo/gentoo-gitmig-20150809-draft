# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xwrits/xwrits-2.18.ebuild,v 1.1 2002/01/10 09:35:08 hallski Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Xwrits reminds you to take wrist breaks, which will hopefully help you prevent repetitive stress injury. It pops up an X window when you should rest; you click on that window, then take a break"

SRC_URI="http://www.lcdf.org/xwrits/xwrits-2.18.tar.gz"
HOMEPAGE="http://www.lcdf.org/xwrits/"

DEPEND="x11-base/xfree"

src_compile() {

	./configure --prefix=/usr \
			--mandir=/usr/share/man	\
			--infodir=/usr/share/info
	assert

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc GESTURES NEWS README
}

