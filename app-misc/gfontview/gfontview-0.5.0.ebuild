# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gfontview/gfontview-0.5.0.ebuild,v 1.2 2001/05/18 17:13:55 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Fontviewer for PostScript Tpe 1 and TrueType"
SRC_URI="http://download.sourceforge.net/gfontview/"${A}
HOMEPAGE="http://gfontview.sourceforge.net"

DEPEND="virtual/glibc
    >=sys-devel/gcc-2.95
	=media-libs/freetype-1.3.1-r2
	>=media-libs/giflib-4.1.0
	>=media-libs/t1lib-1.0.1
	>=x11-libs/gtk+-1.2.8
	virtual/lpr
    nls? ( sys-devel/gettext )
    gnome? ( gnome-base/gnome-libs )"


src_compile() {

  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 $myconf
  try make
}

src_install() {
  try make prefix=${D}/usr/X11R6 install
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
  insinto /usr/X11R6/include/X11/pixmaps/
  doins error.xpm openhand.xpm font.xpm t1.xpm tt.xpm 
}



