# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-1.2.0-r1.ebuild,v 1.2 2000/12/11 06:29:38 drobbins Exp $

P=gnome-media-1.2.0
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-media"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-media/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-1.2.4"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-ncurses
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README*
}




