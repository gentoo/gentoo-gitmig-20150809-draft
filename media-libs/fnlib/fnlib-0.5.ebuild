# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/fnlib/fnlib-0.5.ebuild,v 1.1 2000/08/14 12:30:15 achim Exp $

P=fnlib-0.5
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="media-libs"
DESCRIPTION="Font Library"
SRC_URI="ftp://ftp.enlightenment.org/pub/enlightenment/enlightenment/libs/"${A}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc/X11/fnlib
  make
}

src_install() {                               
  cd ${S}
  
  make prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/X11/fnlib install
  dodoc AUTHORS ChangeLog COPYING* HACKING NEWS README
  dodoc doc/fontinfo.README

}




