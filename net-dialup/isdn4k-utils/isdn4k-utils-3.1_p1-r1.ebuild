# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils-3.1_p1-r1.ebuild,v 1.5 2000/10/30 20:08:26 achim Exp $

A=isdn4k-utils.v3.1pre1.tar.gz   
S=${WORKDIR}/isdn4k-utils
DESCRIPTION="ISDN-4-Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/"${A}
HOMEPAGE="http://www.isdn4linux.de/"

src_unpack() {
  unpack ${A}
  cd ${S}
  sed -e "s:CONFIG_KERNELDIR=.*:CONFIG_KERNELDIR='${WORKDIR}/../../linux-UP-2\.2\.17-r3/work/linux':" ${O}/files/${P}.config > .config
}

src_compile() {                           
  cd ${S}
  try make subconfig
  try make
}

src_install() {                               
  cd ${S}
  dodir /dev
  dodir /usr/sbin
  dodir /usr/bin
  try make install DESTDIR=${D}
  
  dodoc COPYING NEWS README Mini-FAQ/isdn-faq.txt
  mv ${D}/usr/doc/vbox ${D}/usr/doc/isdn4k-utils-3.1_p1-r1
  
  
}











