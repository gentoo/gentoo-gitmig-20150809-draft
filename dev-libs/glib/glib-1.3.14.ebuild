# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Geert Bevin <gbevin@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-1.3.14.ebuild,v 1.1 2002/02/20 22:11:06 gbevin Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.3/${P}.tar.gz"
HOMEPAGE="http://www.gtk.org/"

DEPEND="virtual/glibc"
SLOT="2"

src_compile() {
	local myconf

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
		    --with-threads=posix \
		    --enable-debug=yes || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
	     infodir=${D}/usr/share/info \
	     mandir=${D}/usr/share/man \
	     install || die
    
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS NEWS.pre-1-3 TODO.xml
}





