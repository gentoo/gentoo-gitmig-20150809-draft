# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-1.2.10-r1.ebuild,v 1.1 2001/10/11 10:49:15 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${P}.tar.gz
	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/glib/${P}.tar.gz"
HOMEPAGE="http://www.gtk.org/"

DEPEND="virtual/glibc"

src_compile() {
	local myconf

	./configure --host=${CHOST} 					\
		    --prefix=/usr 					\
		    --infodir=/usr/share/info 				\
		    --mandir=/usr/share/man  				\
		    --with-threads=posix 				\
		    --enable-debug=yes || die

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     infodir=${D}/usr/share/info				\
	     mandir=${D}/usr/share/man					\
	     install || die
    
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS

	cd docs
    	docinto html
    	dodoc glib.html glib_toc.html
}





