# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-1.2.10-r3.ebuild,v 1.1 2001/08/30 04:33:21 woodchip Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtk"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${A}
         ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${A}
         http://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${A}"

DEPEND="virtual/glibc virtual/x11
        >=dev-libs/glib-1.2.10"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/gtk-1.2.10.patch || die
}

src_compile() {
	local myconf

	if [ "${DEBUG}" ]
	then
		myconf="--enable-debug=yes"
	else
		myconf="--enable-debug=no"
	fi

	./configure --host=${CHOST} --prefix=/usr/X11R6 ${myconf} \
	--infodir=/usr/share/info --mandir=/usr/X11R6/man --sysconfdir=/etc/X11 \
	--with-xinput=xfree --with-x || die

	emake || die
}

src_install() {
	make install DESTDIR=${D} || die

	preplib /usr/X11R6

	dodoc AUTHORS COPYING ChangeLog* HACKING
	dodoc NEWS* README* TODO
	docinto docs
	cd docs
	dodoc *.txt *.gif text/*
	cd html
	docinto html
	dodoc *.html *.gif

	#install nice, clean-looking default gtk+ style
	insinto /etc/X11/gtk
	doins ${FILESDIR}/gtkrc
}
