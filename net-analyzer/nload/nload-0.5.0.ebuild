# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nload/nload-0.5.0.ebuild,v 1.9 2004/03/21 12:58:30 mboman Exp $

inherit eutils

DESCRIPTION="console application which monitors network traffic and bandwidth usage in real time"
SRC_URI="mirror://sourceforge/nload/${P}.tar.gz"
HOMEPAGE="http://roland-riegel.de/nload/index_en.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/nload-0.5.0-gcc3-gentoo.patch
}

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

