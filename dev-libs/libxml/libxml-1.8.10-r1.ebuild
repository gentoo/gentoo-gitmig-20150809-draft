# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml/libxml-1.8.10-r1.ebuild,v 1.1 2000/11/25 12:57:02 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-libs/gpm-1.19.3"
RDEPEND="$DEPEND
	>=sys-apps/bash-2.04"

src_compile() {
  cd ${S}       
  LDFLAGS="-lncurses" try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {
  cd ${S}
  try make install prefix=${D}/opt/gnome
  dodoc AUTHORS COPYING* ChangeLog NEWS README
}







