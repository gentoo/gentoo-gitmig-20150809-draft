# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-0.31.1.ebuild,v 1.1 2000/10/05 18:22:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
SRC_URI="ftp://sawmill.sourceforge.net/pub/sawmill/"${A}
HOMEPAGE="http://sawmill.sourceforge.net/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --with-audiofile --with-esd \
	--with-gnome-prefix=/opt/gnome
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  prepinfo /usr/X11R6
  dodoc AUTHORS BUGS COPYING ChangeLog DOC FAQ NEWS README THANKS TODO
}



