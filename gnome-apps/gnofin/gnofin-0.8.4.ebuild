# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gnofin/gnofin-0.8.4.ebuild,v 1.2 2001/06/04 21:57:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="a personal finance application for GNOME"
SRC_URI="ftp://gnofin.sourceforge.net/pub/gnofin/stable/source/${A}
	 http://download.sourceforge.net/gnofin/${A}
	 http://jagger.ME.Berkley.EDU/~dfisher/gnofin/stable/source/${A}"

HOMEPAGE="http://gnofin.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.2.4
	>=gnome-base/libxml-1.8.10"

src_compile() {
  try ./configure --host=${CHOST} --prefix=/opt/gnome 
  try make
}

src_install() {                               
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README*
}





