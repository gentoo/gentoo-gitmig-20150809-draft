# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libunicode/libunicode-0.4-r1.ebuild,v 1.9 2002/08/01 11:59:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Unicode library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.gnome.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc"

src_compile() {                           
	./configure --host=${CHOST} 					\
		    --prefix=/usr || die

	emake || die
}

src_install() {                               
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING.* ChangeLog NEWS README THANKS TODO
}
