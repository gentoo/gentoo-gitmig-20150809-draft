# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit/ORBit-0.5.3.ebuild,v 1.2 2000/08/16 04:38:01 drobbins Exp $

P=ORBit-0.5.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A high-performance, lightweight CORBA ORB aiming for CORBA 2.2 compliance"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/ORBit/"${A}
HOMEPAGE="http://www.labs.redhat.com/orbit/"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/opt/gnome
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/opt/gnome install
  prepinfo /opt/gnome

  dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
  dodoc docs/*.txt docs/IDEA1
  docinto idl
  cd libIDL
  dodoc AUTHORS BUGS COPYING NEWS README*
  docinto popt
  cd ../popt
  dodoc CHANGES COPYING README
}



