# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-0.6.8.ebuild,v 1.1 2001/09/25 15:56:29 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GTK+ bindings for Python"

SRC_URI="ftp://ftp.gtk.org/pub/gtk/python/pygtk-0.6.8.tar.gz"

HOMEPAGE="http://www.daa.com.au/~james/pygtk/"

DEPEND="virtual/python
        >=gnome-base/libglade-0.16
        >=x11-libs/gtk+-1.2.8"

src_compile() {

	./configure --infodir=/usr/share/info \
	            --mandir=/usr/share/man \
	            --prefix=/usr \
	            --with-libglade-config=/opt/gnome/bin/libglade-config \
	            --host=${CHOST} || die
	emake || die
}

src_install () {
	
	make prefix=${D}/usr install || die

#    make DESTDIR=${D} install || die
}

