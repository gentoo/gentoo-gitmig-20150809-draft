# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gdk-pixbuf/gdk-pixbuf-0.11.0-r1.ebuild,v 1.1 2001/10/06 10:06:52 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Image Library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/"${A}

DEPEND=">=x11-libs/gtk+-1.2.0-r4
        gnome? ( >=gnome-base/gnome-libs-1.2.13 )"

src_compile() {

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc/X11/gdk-pixbuf			\

	assert

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog INSTALL README NEWS TODO
}
