# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xwrits/xwrits-2.20.ebuild,v 1.11 2005/05/17 16:29:27 pyrania Exp $

DESCRIPTION="Xwrits reminds you to take wrist breaks, which will hopefully help you prevent repetitive stress injury."

SRC_URI="http://www.lcdf.org/xwrits/xwrits-2.20.tar.gz"
HOMEPAGE="http://www.lcdf.org/xwrits/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "
IUSE=""

DEPEND="virtual/x11"

src_compile() {

	./configure --prefix=/usr \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info
	assert

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc GESTURES NEWS README
}
