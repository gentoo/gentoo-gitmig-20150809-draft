# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-0.6.8-r1.ebuild,v 1.11 2002/12/15 10:44:19 bjb Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GTK+ bindings for Python"

SRC_URI="ftp://ftp.gtk.org/pub/gtk/python/pygtk-0.6.8.tar.gz"

HOMEPAGE="http://www.daa.com.au/~james/pygtk/"

DEPEND="virtual/python
        >=gnome-base/libglade-0.17-r1
        =x11-libs/gtk+-1.2*"

KEYWORDS="x86 ppc sparc alpha"
LICENSE="LGPL-2.1"
SLOT="1.2"

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

