# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libicq2000/libicq2000-0.3.0.ebuild,v 1.2 2002/04/17 21:26:08 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="ICQ 200x compatible ICQ libraries."
SRC_URI="http://prdownloads.sourceforge.net/libicq2000/${P}.tar.gz"
HOMEPAGE="http://ickle.sf.net"
SLOT="0"


DEPEND=">=dev-libs/libsigc++-1.0.4"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--localstatedir=/var/lib \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die

}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}
