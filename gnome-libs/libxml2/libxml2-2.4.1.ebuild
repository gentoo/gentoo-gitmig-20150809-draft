# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-libs/libxml2/libxml2-2.4.1.ebuild,v 1.3 2001/08/31 23:32:48 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/libxml/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2
        >=sys-libs/readline-4.1
	>=sys-libs/zlib-1.1.3" 

src_compile() {
	./configure --host=${CHOST} 					\
		    --prefix=/usr 					\
		    --sysconfdir=/etc 					\
		    --with-zlib  || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}
