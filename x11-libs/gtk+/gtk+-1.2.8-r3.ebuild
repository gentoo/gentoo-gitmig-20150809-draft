# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-1.2.8-r3.ebuild,v 1.1 2000/12/03 23:25:52 drobbins Exp $

P=gtk+-1.2.8
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtk"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/"${A}
HOMEPAGE="http://www.gtk.org"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.8
	>=x11-base/xfree-4.0.1"

src_compile() {
	cd ${S}                           
  	try ./configure --host=${CHOST} --prefix=/usr/X11R6 --infodir=/usr/info --sysconfdir=/etc/X11 --with-xinput=xfree --with-catgets --with-x
	try make
}

src_install() {
	cd ${S}
	try make install prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/X11 
	preplib /usr/X11R6
	into /usr
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

pkg_postinst() {
   ldconfig -r ${ROOT}
}



