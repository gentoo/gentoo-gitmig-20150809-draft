# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.5-r1.ebuild,v 1.5 2001/06/06 16:55:51 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Enlightenment Window Manager"
SRC_URI="ftp://ftp.enlightenment.org/enlightenment/enlightenment/"${A}
HOMEPAGE="http://www.enlightenment.org/"

DEPEND=">=media-libs/fnlib-0.5
	>=media-sound/esound-0.2.19
	=media-libs/freetype-1.3.1-r2
	>=gnome-base/libghttp-1.0.7"


src_compile() {
  
  try CFLAGS="\"${CFLAGS} -I/opt/gnome/include\"" LDFLAGS="-L/opt/gnome/lib" \
	./configure --host=${CHOST} --prefix=/usr/X11R6
  try make
}

src_install() {
  try make prefix=${D}/usr/X11R6 localedir=${D}/usr/X11R6/enlightenment/locale \
	gnulocaledir=${D}/usr/X11R6/enlightenment/locale install
  insinto /etc/env.d
  doins ${FILESDIR}/90enlightenment
  exeinto /usr/X11R6/bin/wm
  doexe ${FILESDIR}/enlightenment
  dodoc AUTHORS ChangeLog COPYING NEWS README 
  docinto sample-scripts
  dosym /usr/X11R6/enlightenment/bin/enlightenment /usr/X11R6/bin/
  dosym /usr/X11R6/enlightenment/bin/enlightenment.install /usr/X11R6/bin/
  dodoc sample-scripts/*
}



