# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-1.2.10-r3.ebuild,v 1.3 2001/09/30 12:10:43 azarah Exp $

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

	#install nice, clean-looking gtk+ style
	insinto /usr/X11R6/share/themes/Gentoo/gtk
	doins ${FILESDIR}/gtkrc
}

pkg_postinst() {
	echo
	echo **********************************************************************
	echo * Older versions added /etc/X11/gtk/gtkrc which changed settings for *
	echo * all themes it seems.  Please remove it manually as it will not due *
	echo * to /env protection.                                                *
	echo *                                                                    *
	echo * NB:  The old gtkrc is available through the new Gentoo gtk theme.  *
	echo **********************************************************************
	echo
}
