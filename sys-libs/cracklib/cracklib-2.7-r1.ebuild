# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.7-r1.ebuild,v 1.4 2000/09/15 20:09:27 drobbins Exp $

A=cracklib2_2.7.orig.tar.gz
A0=${P}-redhat.patch
S=${WORKDIR}/cracklib,2.7
DESCRIPTION="Cracklib"
SRC_URI="ftp://ftp.debian.org/debian/dists/potato/main/source/utils/cracklib2_2.7.orig.tar.gz"

src_unpack() {
  unpack ${A}
  cd ${S}
  patch -p1 <${O}/files/${A0}
  cp Makefile Makefile.orig
#  sed -e "s/DICTPATH=.*/DICTPATH=\"\/usr\/share\/cracklib\/pw_dict\"/" Makefile.orig > Makefile
}

src_compile() { 
  cd ${S}
  try make all                         
}

src_install() {                               
  cd ${S}
  into /usr
  dodir /usr/lib
  dodir /usr/sbin
  dodir /usr/include
  ROOT=${D} try make install
  dodoc HISTORY LICENCE MANIFEST POSTER README
}




