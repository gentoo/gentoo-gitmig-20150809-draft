# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-office/gnome-pim/gnome-pim-1.4.0.ebuild,v 1.1 2001/05/17 00:10:07 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-pim"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-pim/"${A}
HOMEPGAE="http://www.gnome.org/gnome-office/gnome-pim.shtml"

DEPEND=">=gnome-base/gnome-core-1.4.0"
RDEPEND=">=gnome-base/gnome-libs-1.2.13"

src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {                               
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README*
}



