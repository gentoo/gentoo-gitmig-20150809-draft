# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-1.2.9.ebuild,v 1.1 2001/03/09 10:26:59 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtk"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${A}"
HOMEPAGE="http://www.gtk.org"

DEPEND="virtual/glibc
	>=dev-libs/glib-1.2.9
	>=x11-base/xfree-4.0.1"

src_compile() {

  	try ./configure --host=${CHOST} --prefix=/usr/X11R6 \
	--infodir=/usr/X11R6/share/info --mandir=/usr/X11R6/share/man --sysconfdir=/etc/X11 \
	--with-xinput=xfree --with-x
	try make
}

src_install() {

	try make install prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/X11 \
		infodir=${D}/usr/X11R6/share/info mandir=${D}/usr/X11R6/share/man

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




