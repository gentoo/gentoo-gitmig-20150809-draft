# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-1.2.8-r1.ebuild,v 1.5 2000/10/23 11:27:17 achim Exp $

P=gtk+-1.2.8
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtk"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/"${A}
HOMEPAGE="http://www.gtk.org"

src_compile() {
  cd ${S}                           
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etx/X11 \
		--with-xinput=xfree --with-catgets --with-x
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
}




