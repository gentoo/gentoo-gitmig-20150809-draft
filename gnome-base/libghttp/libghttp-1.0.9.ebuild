# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libghttp/libghttp-1.0.9.ebuild,v 1.8 2001/08/31 22:54:33 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libghttp"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc
	>=gnome-base/gnome-env-1.0"

src_compile() {
	./configure --host=${CHOST} --prefix=/opt/gnome 		\
		    --mandir=/opt/gnome/man || die

	emake || die
}

src_install() {                               
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
	docinto html
	dodoc doc/ghttp.html
}
