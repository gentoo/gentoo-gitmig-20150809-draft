# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.2-r1.ebuild,v 1.1 2000/08/08 13:26:23 achim Exp $

P=xmms-1.2.2
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="media-sound"
DESCRIPTION="X MultiMedia System"
SRC_URI="ftp://ftp.xmms.org/xmms/1.2.x/"${A}
HOMEPAGE="http://www.xmms.org/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  CFLAGS="$CFLAGS -I/opt/gnome/include" ./configure --host=${CHOST} --prefix=/usr/X11R6 --with-catgets
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr/X11R6 install
  dodoc AUTHORS ChangeLog COPYING FAQ NEWS README TODO 
  insinto /usr/X11R6/include/X11/pixmaps/
  newins gnomexmms/gnomexmms.xpm xmms.xpm
}




