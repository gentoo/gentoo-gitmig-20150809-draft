# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pppoed/pppoed-0.47-r1.ebuild,v 1.1 2000/08/08 16:35:24 achim Exp $

P=pppoed-0.47
A=pppoed0.47.tgz
S=${WORKDIR}/${P}/pppoed
CATEGORY="net-dialup"
DESCRIPTION="PPP over Ethernet"
SRC_URI=" http://www.davin.ottawa.on.ca/pppoe/pppoed0.47.tgz"
HOMEPAGE="http://www.davin.ottawa.on.ca/pppoe/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/ppp/pppoed
  make
}

src_install() {                               
  cd ${S}
  make DESTDIR=${D} install
  prepman
  dodoc AUTHORS ChangeLog COPYING NEWS README*
  cd ..
  docinto docs
  dodoc docs/*
  docinto contrib
  dodoc contribs/*
}



