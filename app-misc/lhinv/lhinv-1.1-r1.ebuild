# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/lhinv/lhinv-1.1-r1.ebuild,v 1.4 2000/11/01 04:44:12 achim Exp $

P=lhinv-1.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Linux Hardware Inventory"
SRC_URI="http://download.sourceforge.net/lhinv/"${A}
HOMEPAGE="http://lhinv.sourceforge.net"

DEPEND=">=sys-devel/perl-5"

src_compile() {                           
  cd ${S}/cgi
  cp w3hinv w3hinv.orig
  sed -e "s/^my \$HINV =.*/my \$HINV =\"\/usr\/bin\/lhinv\";/" w3hinv.orig > w3hinv
  cd ..
  try make local
}

src_install() {                               
  cd ${S}
  into /usr
  dobin lhinv
  doman lhinv.1
  dodoc AUTHORS BUGS CHANGELOG COPYING README TODO
  newdoc cgi/README README.cgi
  insinto /usr/local/httpd/cgi-bin
  insopts -m 755 
  doins cgi/w3hinv
}



