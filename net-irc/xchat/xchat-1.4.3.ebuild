# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.4.3.ebuild,v 1.1 2000/11/26 20:54:19 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="xchat"
SRC_URI="http://www.xchat.org/files/source/1.4/"${A}
HOMEPAGE="http://www.xchat.org/"

DEPEND=">=media-libs/imlib-1.9.8.1
	gnome? ( >=gnome-base/gnome-core-1.2.2.1 )"

src_compile() {                           
  cd ${S}
  local myopts
  if [ -n "`use gnome`" ]
  then 
	myopts="--enable-gnome --prefix=/opt/gnome"
  else
	myopts="--disable-gnome --prefix=/usr/X11R6"
  fi
  try ./configure --host=${CHOST} --disable-perl --disable-python ${myopts} --with-catgets
  try make
}

src_install() {                               
  cd ${S}
  if [ -n "`use gnome`" ]
  then
  	try make prefix=${D}/opt/gnome install
  else
  	try make prefix=${D}/usr/X11R6 install
  fi
  dodoc AUTHORS COPYING ChangeLog NEWS README
}






