# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libPropList/libPropList-0.10.1-r1.ebuild,v 1.1 2000/08/12 16:46:05 achim Exp $

P=libPropList-0.10.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="x11-libs"
DESCRIPTION="libPropList"
SRC_URI="ftp://ftp.windowmaker.org/pub/release/srcs/current/"${A}
HOMEPAGE="http://www.windowmaker.org/"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr/X11R6
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr/X11R6 install
  dodoc AUTHORS COPYING* ChangeLog README TODO
}




