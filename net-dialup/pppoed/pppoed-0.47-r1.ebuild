# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pppoed/pppoed-0.47-r1.ebuild,v 1.5 2000/11/01 04:44:18 achim Exp $

P=pppoed-0.47
A=pppoed0.47.tgz
S=${WORKDIR}/${P}/pppoed
DESCRIPTION="PPP over Ethernet"
SRC_URI=" http://www.davin.ottawa.on.ca/pppoe/pppoed0.47.tgz"
HOMEPAGE="http://www.davin.ottawa.on.ca/pppoe/"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/ppp/pppoed
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  dodoc AUTHORS ChangeLog COPYING NEWS README*
  cd ..
  docinto docs
  dodoc docs/*
  docinto contrib
  dodoc contribs/*
}



