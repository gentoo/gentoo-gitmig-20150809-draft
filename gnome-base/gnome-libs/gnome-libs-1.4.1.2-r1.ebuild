# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-libs/gnome-libs-1.4.1.2-r1.ebuild,v 1.1 2001/10/06 10:06:50 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Core Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=media-libs/imlib-1.9.10-r1
	>=media-sound/esound-0.2.22
	>=gnome-base/ORBit-0.5.10-r1
	>=x11-libs/gtk+-1.2.10-r4
	<sys-libs/db-2"

src_compile() {                           
	CFLAGS="$CFLAGS -I/usr/include/db1"

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var				\
		    --enable-prefer-db1 || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS HACKING
}
