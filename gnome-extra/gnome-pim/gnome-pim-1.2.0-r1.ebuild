# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pim/gnome-pim-1.2.0-r1.ebuild,v 1.2 2000/11/25 18:59:38 achim Exp $

P=gnome-pim-1.2.0
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-pim"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-pim/"${A}
HOMEPGAE="http://www.gnome.org/gnome-office/gnome-pim.shtml"

DEPEND=">=gnome-base/gnome-core-1.2.4"
RDEPEND=">gnome-base/gnome-libs-1.2.8"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README*
}



