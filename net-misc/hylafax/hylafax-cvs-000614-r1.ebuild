# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafax/hylafax-cvs-000614-r1.ebuild,v 1.3 2000/09/15 20:09:12 drobbins Exp $

P=hylafax-cvs-000614
A=${P}.tar.bz2
S=${WORKDIR}/hylafax
DESCRIPTION="HylaFAX Faxserver"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/"${A}
HOMEPAGE="http://www.hylafax.org"

src_unpack() {
  unpack ${A}
  cd ${S}
  zcat ${O}/files/${P}.patch.gz | patch -p1
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





