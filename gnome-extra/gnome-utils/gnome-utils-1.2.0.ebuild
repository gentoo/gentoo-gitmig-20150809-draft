# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-1.2.0.ebuild,v 1.3 2000/09/15 20:08:53 drobbins Exp $

P=gnome-utils-1.2.0
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-utils"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-utils/"${A}
HOMEPAGE="http://www.gnome.org/"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-catgets --with-ncurses
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README*
}



