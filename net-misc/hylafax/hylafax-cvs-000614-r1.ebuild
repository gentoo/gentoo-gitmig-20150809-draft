# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafax/hylafax-cvs-000614-r1.ebuild,v 1.5 2001/04/30 00:01:17 achim Exp $

P=hylafax-cvs-000614
A=${P}.tar.bz2
S=${WORKDIR}/hylafax
DESCRIPTION="HylaFAX Faxserver"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/"${A}
HOMEPAGE="http://www.hylafax.org"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=sys-devel/gcc-2.95.2
	>=media-libs/tiff-3.5.5
	>=media-libs/jpeg-6b"

src_unpack() {
  unpack ${A}
  cd ${S}
  zcat ${O}/files/${P}.patch.gz | patch -p1
  cd ..
  patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {                           
  cd ${S}   
  try make
}

src_install() {                               
  cd ${S}
  dodir /usr/bin
  dodir /usr/sbin
  dodir /usr/lib/fax
  dodir /usr/libexec
  dodir /usr/man
  dodir /var/spool/fax
  dodir /etc/rc.d/init.d
  try make BASEDIR=${D} install  
  prepman

  dodoc COPYRIGHT README TODO VERSION 
  docinto html
  dodoc html/*.html html/*.gif
  for i in Majordomo Modems Modems/Hayes Modems/Supra Modems/Telebit \
	   Modems/ZyXEL
  do
    docinto html/$i
    dodoc html/$i/*.html
  done
  docinto html/icons
  dodoc html/icons/*.gif
}





