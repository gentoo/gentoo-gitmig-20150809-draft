# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}

DESCRIPTION="Xwrits reminds you to take wrist breaks, which will hopefully help you prevent repetitive stress injury. It pops up an X window when you should rest; you click on that window, then take a break"

SRC_URI="http://www.lcdf.org/xwrits/xwrits-2.19.tar.gz"
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

