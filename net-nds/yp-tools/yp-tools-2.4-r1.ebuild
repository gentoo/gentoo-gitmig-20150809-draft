# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/yp-tools/yp-tools-2.4-r1.ebuild,v 1.1 2000/08/09 23:55:48 achim Exp $

P=yp-tools-2.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="net-nds"
DESCRIPTION="NIS Tools"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/net/NIS/${A}
	 ftp://ftp.uk.kernel.org/pub/linux/utils/net/NIS/${A}
	 ftp://ftp.kernel.org/pub/linux/utils/net/NIS/${A}"
HOMEPAGE="http://www.suse.de/~kukuk/nis/yp-tools/index.html"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/yp
  make
}

src_install() {                               
  cd ${S}
  make DESTDIR=${D} install
  prepman
  dodoc AUTHORS ChangeLog COPYING NEWS README THANKS TODO
  insinto /etc/yp
  doins etc/nicknames
}



