# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer/webalizer-2.01.06.ebuild,v 1.1 2001/04/09 20:59:06 achim Exp $

P=webalizer-2.01-06
A=${P}-src.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Webalizer"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/"${A}
HOMEPAGE="http://www.mrunix.net/webalizer/"

DEPEND="virtual/glibc
	>=media-libs/libgd-1.8.3
	sys-libs/db
    >=sys-libs/zlib-1.1.3"

src_compile() {
  try ./configure --host=${CHOST} --prefix=/usr --with-etcdir=/etc/httpd --mandir=/usr/share/man

  try make
}

src_install() {

  into /usr
  dobin webalizer
  dosym webalizer /usr/bin/webazolver
  doman webalizer.1
  dodir /usr/local/httpd/webalizer
  insinto /etc/httpd
  newins ${FILESDIR}/webalizer-${PV}.conf webalizer.conf
  doins ${FILESDIR}/httpd.webalizer
  dodoc README* CHANGES COPYING Copyright sample.conf

}





