# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-1.2.10.ebuild,v 1.1 2001/04/08 16:26:14 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtk"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${A}
	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${A}
	 http://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${A}"
HOMEPAGE="http://www.gtk.org/"

DEPEND="virtual/glibc
	>=dev-libs/glib-1.2.10
	>=x11-base/xfree-4.0.1"

src_compile() {
	local myconf
	
	if [ "${DEBUG}" ]
	then
		myconf="--enable-debug=yes"
	else
		myconf="--enable-debug=no"
	fi
	
  	try ./configure --host=${CHOST} --prefix=/usr/X11R6 ${myconf}
	--infodir=/usr/X11R6/share/info --mandir=/usr/X11R6/share/man --sysconfdir=/etc/X11 \
	--with-xinput=xfree --with-x
	try make
}

src_install() {
	try make install DESTDIR=${D}

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




