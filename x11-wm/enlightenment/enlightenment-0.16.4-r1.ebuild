# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.4-r1.ebuild,v 1.3 2000/09/15 20:09:30 drobbins Exp $

P=enlightenment-0.16.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Enlightenment Window Manager"
SRC_URI="ftp://ftp.enlightenment.org/pub/enlightenment/enlightenment/"${A}
HOMEPAGE="http://www.enlightenment.org/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --with-catgets
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr/X11R6 localedir=${D}/usr/X11R6/enlightenment/locale \
	gnulocaledir=${D}/usr/X11R6/enlightenment/locale install
  prepman /usr/X11R6
  dodoc AUTHORS ChangeLog COPYING NEWS README 
  docinto sample-scripts
  dodoc sample-scripts/*
}



