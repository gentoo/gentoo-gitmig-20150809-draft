# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Basic"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-print-0.29"

src_compile() {                           
	./configure --host=${CHOST} --prefix=/opt/gnome || die

	emake || die
}

src_install() {                               
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}
