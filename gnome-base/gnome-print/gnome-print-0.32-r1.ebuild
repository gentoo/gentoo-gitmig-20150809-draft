# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.32-r1.ebuild,v 1.1 2001/11/14 00:31:07 hallski Exp $


S=${WORKDIR}/${P}
DESCRIPTION="gnome-print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	 >=gnome-base/libglade-0.17-r1"

DEPEND="${RDEPEND}
	sys-devel/gettext
        sys-devel/perl
        >=app-text/ghostscript-6.50-r2"

src_compile() {
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc 					\
		    --localstatedir=/var/lib
	assert

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
