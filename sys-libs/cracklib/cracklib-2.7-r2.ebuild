# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.7-r2.ebuild,v 1.8 2002/08/01 11:59:04 seemant Exp $

A=cracklib2_${PV}.orig.tar.gz
A0=${P}-redhat.patch
S=${WORKDIR}/cracklib,${PV}
DESCRIPTION="Cracklib"
SRC_URI="ftp://ftp.debian.org/debian/dists/potato/main/source/utils/${A}"
LICENSE="CRACKLIB"
KEYWORDS="x86 -ppc"
SLOT="0"
HOMEPAGE="http://www.users.dircon.co.uk/~crypto/"

DEPEND="virtual/glibc"

src_unpack() {

  unpack ${A}
  cd ${S}
  patch -p1 <${FILESDIR}/${A0}
  patch -p1 <${FILESDIR}/${P}-gentoo.diff

}

src_compile() {

  # Parallel make does not work for 2.7
  try make all

}

src_install() {

  dodir /usr/lib
  dodir /usr/sbin
  dodir /usr/include
  dodir /usr/share/cracklib

  try make DESTDIR=${D} install

  mv ${D}/usr/lib ${D}
  preplib /

  dodoc HISTORY LICENCE MANIFEST POSTER README

}
