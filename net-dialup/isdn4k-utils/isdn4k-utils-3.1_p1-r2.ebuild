# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils-3.1_p1-r2.ebuild,v 1.1 2001/03/12 11:14:42 achim Exp $

A=isdn4k-utils.v3.1pre1.tar.gz   
S=${WORKDIR}/isdn4k-utils
DESCRIPTION="ISDN-4-Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/"${A}
HOMEPAGE="http://www.isdn4linux.de/"

DEPEND="virtual/glibc
	>=sys-kernel/linux-sources-2.4
	>=sys-libs/ncurses-5.1
	>=sys-libs/gdbm-1.8.0
	mysql? ( >=dev-db/mysql-3.23.26 )
	>=dev-lang/tcl-tk-8.1"

src_unpack() {
  unpack ${A}
  cd ${S}
 # sed -e "s:CONFIG_KERNELDIR=.*:CONFIG_KERNELDIR='${WORKDIR}/../../linux-2\.4\.0_rc103/work/linux':" ${O}/files/${P}.config > .config
  cp ${FILESDIR}/${P}.config .config
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











