# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/WindowMaker/WindowMaker-0.65.0.ebuild,v 1.1 2001/05/16 15:40:07 achim Exp $

A="${P}.tar.gz WindowMaker-extra-0.1.tar.bz2"
S=${WORKDIR}/${P}
DESCRIPTION="Window Maker"
SRC_URI="ftp://ftp.windowmaker.org/pub/source/release/${P}.tar.gz
	ftp://ftp.windowmaker.org/pub/source/release/WindowMaker-extra-0.1.tar.bz2"
HOMEPAGE="http://www.windowmaker.org/"

DEPEND="virtual/glibc virtual/x11
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
	>=media-libs/giflib-4.1.0
	>=x11-libs/libPropList-0.10.1"

src_compile() {                       
  local myconf
  if [ "`use gnome`" ] ; then
	myconf="--enable-gnome"
  fi
  if [ "`use kde`" ] ; then
	myconf="$myconf --enable-kde"
  fi    
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc/X11 \
	--with-x --enable-newstyle --enable-superfluous $myconf
  try make
  cd ../WindowMaker-extra-0.1
  try ./configure --host=${CHOST} --prefix=/usr/X11R6
  try make
}

src_install() {                               
  try make prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/X11 install
  exeinto /usr/X11R6/bin/wm
  doexe ${FILESDIR}/windowmaker
  cp -f WindowMaker/plmenu ${D}/etc/X11/WindowMaker/WMRootMenu
  dodoc AUTHORS BUGFORUM BUGS ChangeLog COPYING* FAQ* README* NEWS TODO
  
  cd ../WindowMaker-extra-0.1
  try make prefix=${D}/usr/X11R6 install
  newdoc README README.extra
  
  

}




