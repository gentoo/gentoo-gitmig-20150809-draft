# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils.v3.1p1-r1.ebuild,v 1.1 2000/08/08 16:35:24 achim Exp $

P=isdn4k-utils.v3.1p1
A=isdn4k-utils.v3.1pre1.tar.gz   
S=${WORKDIR}/isdn4k-utils
CATEGORY="net-dialup"
DESCRIPTION="ISDN-4-Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/"${A}
HOMEPAGE="http://www.isdn4linux.de/"

src_compile() {                           
  cd ${S}
  sed -e "s:CONFIG_KERNELDIR=.*:CONFIG_KERNELDIR='${WORKDIR}/../../../sys-kernel/linux-UP-2\.2\.17p13/work/linux':" ${O}/files/${P}.config > .config
  make subconfig
  make
}

src_install() {                               
  cd ${S}
  dodir /dev
  dodir /usr/sbin
  dodir /usr/bin
  make install DESTDIR=${D}
  dodir /usr/doc/${P}
  mv ${D}/usr/doc/vbox ${D}/usr/doc/${P}
  dodoc COPYING NEWS README Mini-FAQ/isdn-faq.txt

}




