# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.7-r2.ebuild,v 1.1 2001/02/07 16:10:52 achim Exp $

A=cracklib2_${PV}.orig.tar.gz
A0=${P}-redhat.patch
S=${WORKDIR}/cracklib,${PV}
DESCRIPTION="Cracklib"
SRC_URI="ftp://ftp.debian.org/debian/dists/potato/main/source/utils/${A}"

DEPEND="virtual/glibc"

src_unpack() {

  unpack ${A}
  cd ${S}
  patch -p1 <${FILESDIR}/${A0}

}

src_compile() {

  # Parallel make does not work for 2.7
  try RPM_OPT_FLAGS=\"${CFLAGS}\" make DICTPATH=\"/usr/share/cracklib/pw_dict\" all

}

src_install() {

  dodir /usr/lib
  dodir /usr/sbin
  dodir /usr/include
  dodir /usr/share/cracklib

  ROOT=${D} try make DICTPATH=\"/usr/share/cracklib/pw_dict\" install

  mv ${D}/usr/lib ${D}
  preplib /

  dodoc HISTORY LICENCE MANIFEST POSTER README

}