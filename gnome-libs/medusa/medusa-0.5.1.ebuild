# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-libs/medusa/medusa-0.5.1.ebuild,v 1.5 2001/08/31 23:32:48 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="medusa"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-vfs-1.0"

src_compile() {
	./configure --host=${CHOST} 					\
		    --prefix=/opt/gnome					\
		    --sysconfdir=/etc/opt/gnome 			\
		    --mandir=/opt/gnome/man 				\
		    --sharedstatedir=/var/lib 				\
		    --localstatedir=/var/lib 				\
		    --enable-prefere-db1 || die

	emake medusainitdir=/tmp || die
}

src_install() {
	make DESTDIR=${D} medusainitdir=/tmp install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
