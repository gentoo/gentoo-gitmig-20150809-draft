# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/yp-tools/yp-tools-2.4-r2.ebuild,v 1.2 2001/05/10 09:39:40 achim Exp $

P=yp-tools-2.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="NIS Tools"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/net/NIS/${A}
	 ftp://ftp.uk.kernel.org/pub/linux/utils/net/NIS/${A}
	 ftp://ftp.kernel.org/pub/linux/utils/net/NIS/${A}"
HOMEPAGE="http://www.suse.de/~kukuk/nis/yp-tools/index.html"

DEPEND="virtual/glibc"


src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/yp \
	--mandir=/usr/share/man
  try make
}

src_install() {                               
  try make DESTDIR=${D} install
  dodoc AUTHORS ChangeLog COPYING NEWS README THANKS TODO
  insinto /etc/yp
  doins etc/nicknames
  # This messes up boot so we remove it
  rm -d ${D}/bin/ypdomainname
}



