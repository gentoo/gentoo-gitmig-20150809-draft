# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mime-data/gnome-mime-data-1.0.1.ebuild,v 1.1 2002/01/20 22:56:58 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gnome-mime-data"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=dev-util/pkgconfig-0.8.0
	>=dev-util/intltool-0.11"

src_compile() {
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib

	emake || die
}

src_install() {
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib	\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}
