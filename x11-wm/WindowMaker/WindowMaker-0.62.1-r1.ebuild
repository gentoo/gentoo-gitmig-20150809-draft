# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/WindowMaker/WindowMaker-0.62.1-r1.ebuild,v 1.5 2001/05/07 15:51:46 achim Exp $

P=WindowMaker-0.62.1
A="${P}.tar.gz WindowMaker-extra-0.1.tar.bz2"
S=${WORKDIR}/${P}
DESCRIPTION="Window Maker"
SRC_URI="ftp://ftp.windowmaker.org/pub/release/srcs/current/WindowMaker-0.62.1.tar.gz
	ftp://ftp.windowmaker.org/pub/release/srcs/current/WindowMaker-extra-0.1.tar.bz2"
HOMEPAGE="http://www.windowmaker.org/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
	>=media-libs/giflib-4.1.0
	>=x11-libs/libPropList-0.10.1
	>=x11-base/xfree-4.0.1"

src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc/X11 \
	--enable-gnome --enable-kde --with-x --enable-newstyle --enable-superfluous
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




