# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linux-identd/linux-identd-1.2.ebuild,v 1.11 2005/04/01 15:55:46 agriffis Exp $

IUSE=""
DESCRIPTION="A real IDENT daemon for linux."
HOMEPAGE="http://www.fukt.bth.se/~per/identd"
SRC_URI="http://www.fukt.bth.se/~per/identd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/libc"

src_compile() {
	emake || die
}

src_install() {
	dodir /etc/init.d /usr/sbin /usr/share/man/man8
	dodoc README COPYING ChangeLog
	make install DESTDIR=${D} MANDIR=/usr/share/man || die
	cp ${FILESDIR}/identd ${D}/etc/init.d
}
