# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.2-r1.ebuild,v 1.3 2000/09/15 20:09:05 drobbins Exp $

P=xmms-1.2.2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="X MultiMedia System"
SRC_URI="ftp://ftp.xmms.org/xmms/1.2.x/"${A}
HOMEPAGE="http://www.xmms.org/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  CFLAGS="$CFLAGS -I/opt/gnome/include" try ./configure --host=${CHOST} --prefix=/usr/X11R6 --with-catgets
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr/X11R6 install
  dodoc AUTHORS ChangeLog COPYING FAQ NEWS README TODO 
  insinto /usr/X11R6/include/X11/pixmaps/
  newins gnomexmms/gnomexmms.xpm xmms.xpm
}




