# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Terry Chan <tchan@enteract.com>
# $Header: /var/cvsroot/gentoo-x86/dev-util/xdelta/xdelta-1.1.3.ebuild,v 1.1 2002/01/10 22:22:43 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Computes changes between binary or text files and creates deltas"
SRC_URI="http://prdownloads.sourceforge.net/xdelta/${P}.tar.gz"
HOMEPAGE="http://xdelta.sourceforge.net"
DEPEND="virtual/glibc
        >=dev-libs/glib-1.2.10
        >=sys-libs/zlib-1.1.3"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
        dodoc AUTHORS ChangeLog COPYING NEWS README
}
