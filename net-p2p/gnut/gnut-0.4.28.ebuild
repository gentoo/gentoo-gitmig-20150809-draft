# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnut/gnut-0.4.28.ebuild,v 1.14 2004/06/25 00:33:15 agriffis Exp $

IUSE=""

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Text-mode gnutella client"
SRC_URI="http://alge.anart.no/ftp/pub/gnutella/${P}.tar.gz"
HOMEPAGE="http://www.gnutelliums.com/linux_unix/gnut/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_compile() {
	cat /dev/null | ./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dohtml doc/*.html
	dodoc 	doc/TUTORIAL AUTHORS COPYING ChangeLog GDJ HACKING \
		INSTALL NEWS README TODO
}
