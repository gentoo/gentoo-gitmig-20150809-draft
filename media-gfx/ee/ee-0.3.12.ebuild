# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ee/ee-0.3.12.ebuild,v 1.5 2000/11/03 17:47:44 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="ee"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-libs-1.2.4"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome --with-catgets
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING ChangeLog NEWS README
}



