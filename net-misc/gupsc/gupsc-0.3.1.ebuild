# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/gupsc/gupsc-0.3.1.ebuild,v 1.1 2001/06/04 10:34:15 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A Gnome client for the Network UPS Tools (nut)"
SRC_URI="http://www.stud.ifi.uio.no/~hennikul/gupsc/download/"${A}
HOMEPAGE="http://www.stud.ifi.uio.no/~hennikul/gupsc/"

DEPEND=">=gnome-base/gnome-libs-1.2.4"


src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/opt/gnome 
  try make
}

src_install() {                               
  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}



