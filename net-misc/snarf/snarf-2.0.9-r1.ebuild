# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/snarf/snarf-2.0.9-r1.ebuild,v 1.1 2000/08/09 22:58:29 achim Exp $

P=snarf-2.0.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="net-misc"
DESCRIPTION="A full featured small web-spider"
SRC_URI="http://www.xach.com/snarf/"${A}
HOMEPAGE="http://www.xach.com/snarf/"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr
  make
}

src_install() {                               
  cd ${S}
  into /usr
  dobin snarf
  doman snarf.1
  dodoc COPYING ChangeLog README TODO
}



