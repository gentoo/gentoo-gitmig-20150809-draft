# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.3.ebuild,v 1.2 2000/11/05 11:15:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="X MultiMedia System"
SRC_URI="ftp://ftp.xmms.org/xmms/1.2.x/"${A}
HOMEPAGE="http://www.xmms.org/"

DEPEND="gnome? ( >=gnome-base/gnome-core-1.2.2.1 )
	>=gnome-base/libxml-1.8.10
	>=media-libs/libmikmod-3.1.9
	>=media-libs/mesa-glu-3.2.1
	>=x11-libs/gtk+-1.2.8"

RDEPEND="gnome? ( >=gnome-base/gnome-core-1.2.2.1 )
	 >=gnome-base/libxml-1.8.10
  	 >=media-libs/libmikmd-3.1.9
	 >=x11-libs/gtk+-1.2.8"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  local myopts
  if [ -n "`use gnome`" ]
  then
	myopts="--prefix=/opt/gnome --with-gnome"
  else
	myopts="--prefix=/usr/X11R6 --without-gnome"
  fi
  CFLAGS="$CFLAGS -I/opt/gnome/include" try ./configure --host=${CHOST} ${myopts} --with-catgets
  try make

}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr/X11R6 install
  dodoc AUTHORS ChangeLog COPYING FAQ NEWS README TODO 
  insinto /usr/X11R6/include/X11/pixmaps/
  donewins gnomexmms/gnomexmms.xpm xmms.xpm
}




