# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gdk-pixbuf/gdk-pixbuf-0.11.0-r2.ebuild,v 1.1 2001/10/11 22:30:37 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Image Library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
        >=gnome-base/gnome-libs-1.4.1.2-r1"

src_compile() {

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc/X11/gdk-pixbuf

	assert

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc/X11/gdk-pixbuf 			\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog INSTALL README NEWS TODO
}
