# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.7-r1.ebuild,v 1.1 2000/08/03 16:22:36 achim Exp $

P=cracklib-2.7
A=cracklib_2.7.tar.gz
A0=${P}-redhat.patch
S=${WORKDIR}/cracklib,2.7
CATEGORY="sys-libs"
DESCRIPTION="Cracklib"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/"${A}

src_unpack() {
  unpack ${A}
  cd ${S}
  patch -p1 <${O}/files/${A0}
  cp Makefile Makefile.orig
#  sed -e "s/DICTPATH=.*/DICTPATH=\"\/usr\/share\/cracklib\/pw_dict\"/" Makefile.orig > Makefile
}

src_compile() { 
  cd ${S}
  make all                         
}

src_install() {                               
  cd ${S}
  into /usr
  dodir /usr/lib
  dodir /usr/sbin
  dodir /usr/include
  ROOT=${D} make install
  dodoc HISTORY LICENCE MANIFEST POSTER README
}




