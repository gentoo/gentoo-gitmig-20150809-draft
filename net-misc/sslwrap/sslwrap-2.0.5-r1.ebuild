# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/sslwrap/sslwrap-2.0.5-r1.ebuild,v 1.2 2000/08/16 04:38:20 drobbins Exp $

P=sslwrap-2.0.5
A=sslwrap.tar.gz
S=${WORKDIR}/sslwrap205
DESCRIPTION="TSL/SSL - Port Wrapper"
SRC_URI="http://www.rickk.com/sslwrap/"${A}
HOMEPAGE="http://www.rickk.com/sslwrap/"

src_unpack () {
  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
}

src_compile() {                           
  cd ${S}
  make
}

src_install() {                               
  cd ${S}
  into /usr
  dosbin sslwrap
  dodoc README
  docinto html
  dodoc docs.html
}



