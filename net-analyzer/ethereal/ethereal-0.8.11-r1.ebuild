# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.8.11-r1.ebuild,v 1.1 2000/08/08 16:06:07 achim Exp $

P=ethereal-0.8.11
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="net-analyzer"
DESCRIPTION="ethereal"
SRC_URI="http://ethereal.zing.org/distribution/${A}
	 ftp://ethereal.zing.org/pub/ethereal/${A}"
HOMEPAGE="http://ethereal.zing.org/"
src_compile() {                           
  cd ${S}
  LDFLAGS="-L/usr/lib -lz" ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc/ethereal 
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/ethereal install
  prepman /usr/X11R6
  dodoc AUTHORS COPYING ChangeLog INSTALL.* NEWS README* TODO

}



