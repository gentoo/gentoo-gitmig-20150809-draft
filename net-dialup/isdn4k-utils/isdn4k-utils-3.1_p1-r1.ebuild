# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils-3.1_p1-r1.ebuild,v 1.7 2001/01/05 03:21:55 achim Exp $

A=isdn4k-utils.v3.1pre1.tar.gz   
S=${WORKDIR}/isdn4k-utils
DESCRIPTION="ISDN-4-Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/"${A}
HOMEPAGE="http://www.isdn4linux.de/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=sys-libs/gdbm-1.8.0
	>=dev-db/mysql-3.23.26
	>=dev-lang/tcl-tk-8.1"

src_unpack() {
  unpack ${A}
  cd ${S}
  sed -e "s:CONFIG_KERNELDIR=.*:CONFIG_KERNELDIR='${WORKDIR}/../../linux-2\.4\.0_rc103/work/linux':" ${O}/files/${P}.config > .config
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











