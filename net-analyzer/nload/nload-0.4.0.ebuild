# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nload/nload-0.4.0.ebuild,v 1.5 2002/08/14 12:12:28 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="console application which monitors network traffic and bandwidth usage in real time"
SRC_URI="mirror://sourceforge/nload/${P}.tar.gz"
HOMEPAGE="http://roland-riegel.de/nload/index_en.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--host=${CHOST} || die "./configure failed"
	
	emake || die "compile failed"
}

src_install () {
	make DESTDIR=${D} install
	dodoc README INSTALL ChangeLog AUTHORS
}

