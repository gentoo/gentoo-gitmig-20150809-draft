# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/gdk-pixbuf/gdk-pixbuf-0.18.0-r1.ebuild,v 1.6 2002/08/14 13:08:09 murphy Exp $

inherit virtualx libtool

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Image Library"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"

DEPEND="media-libs/jpeg
	media-libs/tiff
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.14-r1
	>=media-libs/libpng-1.2.1
	>=gnome-base/gnome-libs-1.4.1.2-r1
	=sys-libs/db-1.85*"
# We need gnome-libs here, else gnome support do not get compiled into
# gdk-pixbuf (the GnomeCanvasPixbuf library )

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_unpack() {

	unpack ${A}

	cp ${S}/demo/Makefile.in ${S}/demo/Makefile.in.orig
	sed -e 's:LDADD = :LDADD = $(LIBJPEG) $(LIBTIFF) $(LIBPNG) :' \
		${S}/demo/Makefile.in.orig > ${S}/demo/Makefile.in
}

src_compile() {

	#update libtool, else we get the "relink bug"
	elibtoolize

	econf --sysconfdir=/etc/X11/gdk-pixbuf || die

	#build needs to be able to
	#connect to an X display.
	Xemake || die
}

src_install() {

	einstall \
		sysconfdir=${D}/etc/X11/gdk-pixbuf || die

	#fix permissions on the loaders
	chmod a+rx ${D}/usr/lib/gdk-pixbuf/loaders
	chmod a+r ${D}/usr/lib/gdk-pixbuf/loaders/*

	dodoc AUTHORS COPYING* ChangeLog INSTALL README NEWS TODO
}

