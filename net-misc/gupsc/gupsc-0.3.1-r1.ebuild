# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/gupsc/gupsc-0.3.1-r1.ebuild,v 1.1 2001/10/07 15:02:08 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Gnome client for the Network UPS Tools (nut)"
SRC_URI="http://www.stud.ifi.uio.no/~hennikul/gupsc/download/${P}.tar.bz2"
HOMEPAGE="http://www.stud.ifi.uio.no/~hennikul/gupsc/"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"


src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/usr 
  try pmake
}

src_install() {                               
  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}



