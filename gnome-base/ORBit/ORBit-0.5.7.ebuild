# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit/ORBit-0.5.7.ebuild,v 1.1 2001/03/06 05:21:09 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A high-performance, lightweight CORBA ORB aiming for CORBA 2.2 compliance"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.labs.redhat.com/orbit/"

DEPEND="virtual/glibc
	>=sys-apps/tcp-wrappers-7.6
	>=dev-libs/glib-1.2.8"

RDEPEND="virtual/glibc
	 >=dev-libs/glib-1.2.8"

src_compile() {

  try ./configure --host=${CHOST} --prefix=/opt/gnome \
        --sysconfdir=/etc/opt/gnome --infodir=/opt/gnome/share/info
  try make
}

src_install() {

  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome \
        infodir=${D}/opt/gnome/share/info install

  dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
  dodoc docs/*.txt docs/IDEA1
  docinto idl
  cd libIDL
  dodoc AUTHORS BUGS COPYING NEWS README*
  docinto popt
  cd ../popt
  dodoc CHANGES COPYING README
}




