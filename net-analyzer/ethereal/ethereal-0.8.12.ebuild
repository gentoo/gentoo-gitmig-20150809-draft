# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.8.12.ebuild,v 1.1 2000/10/05 00:13:01 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="ethereal"
SRC_URI="http://ethereal.zing.org/distribution/${A}
	 ftp://ethereal.zing.org/pub/ethereal/${A}"
HOMEPAGE="http://ethereal.zing.org/"
src_compile() {                           
  cd ${S}
  LDFLAGS="-L/usr/lib -lz" try ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc/ethereal 
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/ethereal install
  prepman /usr/X11R6
  dodoc AUTHORS COPYING ChangeLog INSTALL.* NEWS README* TODO

}



