# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.4.2.ebuild,v 1.3 2000/08/25 02:20:16 drobbins Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="xchat"
SRC_URI="http://www.xchat.org/files/source/1.4/"${A}
HOMEPAGE="http://www.xchat.org/"

src_compile() {                           
  cd ${S}
  local myopts
  if [ -n "`use gnome`" ]
  then 
	myopts="--enable-gnome --prefix=/opt/gnome"
  else
	myopts="--disable-gnome --prefix=/usr/X11R6"
  fi
  ./configure --host=${CHOST} --disable-perl --disable-python ${myopts} --with-catgets
  make
}

src_install() {                               
  cd ${S}
  if [ -n "`use gnome`" ]
  then
  	make prefix=${D}/opt/gnome install
  else
  	make prefix=${D}/usr/X11R6 install
  fi
  dodoc AUTHORS COPYING ChangeLog NEWS README
  #FOR TESTING
  mknod ${D}/var/db/pkg/${CATEGORY}/${P}/foo b 4 0
}






