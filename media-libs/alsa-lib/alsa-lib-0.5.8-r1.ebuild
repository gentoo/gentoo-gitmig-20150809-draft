# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-0.5.8-r1.ebuild,v 1.1 2000/08/08 13:24:40 achim Exp $

P=alsa-lib-0.5.8
A=${P}.tar.bz2
S=${WORKDIR}/${P}
CATEGORY="media-libs"
DESCRIPTION="Advanced Linux Sound Architecture / Library"
SRC_URI="ftp://ftp.alsa-project.org/pub/lib/"${A}
HOMEPAGE="http://www.alsa-project.org/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr
  make
}

src_install() {                               
  cd ${S}
  make DESTDIR=${D} install
  dodoc ChangeLog COPYING 
}




