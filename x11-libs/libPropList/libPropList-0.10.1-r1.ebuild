# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libPropList/libPropList-0.10.1-r1.ebuild,v 1.4 2000/11/01 04:44:24 achim Exp $

P=libPropList-0.10.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libPropList"
SRC_URI="ftp://ftp.windowmaker.org/pub/release/srcs/current/"${A}
HOMEPAGE="http://www.windowmaker.org/"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr/X11R6
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr/X11R6 install
  dodoc AUTHORS COPYING* ChangeLog README TODO
}




