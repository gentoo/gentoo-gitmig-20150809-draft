# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/gupsc/gupsc-0.3.0.ebuild,v 1.1 2000/08/15 15:27:12 achim Exp $

P=gupsc-0.3.0
A=${P}.tar.bz2
S=${WORKDIR}/${P}
CATEGORY="gnome-apps"
DESCRIPTION="A Gnome client for the Network UPS Tools (nut)"
SRC_URI="http://www.stud.ifi.uio.no/~hennikul/gupsc/download/"${A}
HOMEPAGE="http://www.stud.ifi.uio.no/~hennikul/gupsc/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/opt/gnome --with-catgets
  make
}

src_install() {                               
  cd ${S}
  make DESTDIR=${D} install
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}



