# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-core/gnome-core-1.2.3.ebuild,v 1.1 2000/10/31 02:43:29 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-core"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-kde-datadir=/opt/kde2
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  prepman /opt/gnome
  dodoc AUTHORS COPYING* ChangeLog README NEWS
}




