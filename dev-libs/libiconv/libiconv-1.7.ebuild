# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiconv/libiconv-1.7.ebuild,v 1.1 2001/12/06 05:03:22 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Converts between character encodings"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc"

src_compile() {                           
	./configure --host=${CHOST} 					\
		    --prefix=/usr || die

	emake || die
}

src_install() {                               
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING.* ChangeLog NEWS README* THANKS 
	dodoc TODO NOTES PORTS DESIGN
}
