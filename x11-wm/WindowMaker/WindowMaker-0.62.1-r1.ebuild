# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/WindowMaker/WindowMaker-0.62.1-r1.ebuild,v 1.1 2000/08/12 17:01:34 achim Exp $

P=WindowMaker-0.62.1
A="${P}.tar.gz WindowMaker-extra-0.1.tar.bz2"
S=${WORKDIR}/${P}
CATEGORY="x11-wm"
DESCRIPTION="Window Maker"
SRC_URI="ftp://ftp.windowmaker.org/pub/release/srcs/current/WindowMaker-0.62.1.tar.gz
	ftp://ftp.windowmaker.org/pub/release/srcs/current/WindowMaker-extra-0.1.tar.bz2"
HOMEPAGE="http://www.windowmaker.org/"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc/X11 \
	--enable-gnome --enable-kde --with-x --enable-newstyle --enable-superfluous
  make
  cd ../WindowMaker-extra-0.1
  ./configure --host=${CHOST} --prefix=/usr/X11R6
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/X11 install
  cp -f WindowMaker/plmenu ${D}/etc/X11/WindowMaker/WMRootMenu
  strip ${D}/usr/X11R6/bin/*
  strip ${D}/usr/X11R6/GNUstep/Apps/WPrefs.app/WPrefs
  dodoc AUTHORS BUGFORUM BUGS ChangeLog COPYING* FAQ* README* NEWS TODO
  
  cd ../WindowMaker-extra-0.1
  make prefix=${D}/usr/X11R6 install
  newdoc README README.extra
  prepman /usr/X11R6
  
  

}




