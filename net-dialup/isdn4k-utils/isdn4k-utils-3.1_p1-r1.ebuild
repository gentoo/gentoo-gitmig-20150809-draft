# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils-3.1_p1-r1.ebuild,v 1.2 2000/09/10 17:55:32 achim Exp $

P=isdn4k-utils.v3.1p1
A=isdn4k-utils.v3.1pre1.tar.gz   
S=${WORKDIR}/isdn4k-utils
DESCRIPTION="ISDN-4-Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/"${A}
HOMEPAGE="http://www.isdn4linux.de/"

src_compile() {                           
  cd ${S}
  sed -e "s:CONFIG_KERNELDIR=.*:CONFIG_KERNELDIR='${WORKDIR}/../../linux-UP-2\.2\.17-r1/work/linux':" ${O}/files/${P}.config > .config
  make subconfig
  make
}

src_install() {                               
  cd ${S}
  dodir /dev
  dodir /usr/sbin
  dodir /usr/bin
  make install DESTDIR=${D}
  prepman
  dodir /usr/doc/${P}
  mv ${D}/usr/doc/vbox ${D}/usr/doc/${PF}
  dodoc COPYING NEWS README Mini-FAQ/isdn-faq.txt

}








