# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gdk-pixbuf/gdk-pixbuf-0.16.0-r4.ebuild,v 1.1 2002/02/17 20:23:43 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Image Library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
	media-libs/libpng
	media-libs/tiff
	media-libs/jpeg
	dev-libs/glib
	sys-libs/zlib
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"
# We need gnome-libs here, else gnome support do not get compiled into
# gdk-pixbuf (the GnomeCanvasPixbuf library )

src_unpack() {

	unpack ${A}

	cp ${S}/demo/Makefile.in ${S}/demo/Makefile.in.orig
	sed -e 's:LDADD = :LDADD = $(LIBJPEG) $(LIBTIFF) $(LIBPNG) :' \
		${S}/demo/Makefile.in.orig > ${S}/demo/Makefile.in
}

src_compile() {

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc/X11/gdk-pixbuf || die

	emake || die
}

src_install() {

	make prefix=${D}/usr \
	     sysconfdir=${D}/etc/X11/gdk-pixbuf \
	     install || die

	#fix the /usr/lib/gdk-pixbuf/loaders/* issue where they do
	#not get installed on the first merge
	rmdir ${D}/usr/lib/gdk-pixbuf/loaders >/dev/null 2>/dev/null
	if [ $? -eq 0 ]
	then
		cd ${S}/gdk-pixbuf/.libs
		dodir /usr/lib/gdk-pixbuf/loaders

		for x in *U
		do
			mv $x ${x/U/}
		done

		exeinto /usr/lib/gdk-pixbuf/loaders
		for x in libpixbufloader-*.so.?.*
		do
			doexe $x
			dosym ${x##*/} /usr/lib/gdk-pixbuf/loaders/${x%%.so.*}.so
			dosym ${x##*/} /usr/lib/gdk-pixbuf/loaders/${x%%.so.*}.so.1
		done
		insinto /usr/lib/gdk-pixbuf/loaders
		doins libpixbufloader-*.{a,la}
	fi

	chmod a+rx ${D}/usr/lib/gdk-pixbuf/loaders
	chmod a+r ${D}/usr/lib/gdk-pixbuf/loaders/*

	dodoc AUTHORS COPYING* ChangeLog INSTALL README NEWS TODO
}

