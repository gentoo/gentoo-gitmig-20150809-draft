# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-1.99.9.ebuild,v 1.1 2002/06/06 23:50:39 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+2  bindings for Python"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/python/v2.0/${P}.tar.gz"
HOMEPAGE="http://www.daa.com.au/~james/pygtk/"

DEPEND="virtual/python
        >=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	>=x11-libs/pango-1.0.0
	>=dev-libs/atk-1.0.0
	>=gnome-base/libglade-1.99.10"

SLOT="2.0"
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
	dodoc AUTHORS COPYING ChangeLog INSTALL MAPPING NEWS README THREADS TODO
#    make DESTDIR=${D} install || die
}

