# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-0.6.8-r1.ebuild,v 1.1 2001/10/06 11:24:06 azarah Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GTK+ bindings for Python"

SRC_URI="ftp://ftp.gtk.org/pub/gtk/python/pygtk-0.6.8.tar.gz"

HOMEPAGE="http://www.daa.com.au/~james/pygtk/"

DEPEND="virtual/python
        >=gnome-base/libglade-0.17-r1
        >=x11-libs/gtk+-1.2.10-r4"

src_compile() {

	./configure --infodir=/usr/share/info \
	            --mandir=/usr/share/man \
	            --prefix=/usr \
	            --with-libglade-config=/usr/bin/libglade-config \
	            --host=${CHOST} || die
	emake || die
}

src_install () {
	
	make prefix=${D}/usr install || die

#    make DESTDIR=${D} install || die
}

