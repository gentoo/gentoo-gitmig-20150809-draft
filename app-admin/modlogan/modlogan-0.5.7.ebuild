# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/modlogan/modlogan-0.5.7.ebuild,v 1.1 2000/11/26 20:54:15 achim Exp $

A="${P}.tar.gz gd-1.8.1.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Logfile Analyzer"
SRC_URI="http://www.kneschke.de/projekte/modlogan/download/${P}.tar.gz
	 http://www.kneschke.de/projekte/modlogan/download/gd-1.8.1.tar.gz"

DEPEND=">=sys-libs/glibc-2.1.3
	>=media-libs/freetype-1.3.1
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.8
	>=dev-libs/libpcre-3.2
	>=dev-db/mysql-3.23.26
	>=x11-base/xfree-4.0.1"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}/../gd-1.8.1
  CFLAGS="$CFLAGS -I/usr/include/freetype" try ./configure  
  try make
  cp .libs/libgd.so.0.0.0 libgd.so.0.0.0
  ln -s libgd.so.0.0.0 libgd.so
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --enable-plugins \
	--with-mysql=/usr --with-gd=${WORKDIR}/gd-1.8.1/ \
	--disable-check-dynamic
  try make
}

src_install() {                               
  cd ${S}/../gd-1.8.1
  into /usr
  dolib libgd.so.0.0.0
  cd ${S}
  try make prefix=${D}/usr install
  preplib /usr
  dodoc AUTHORS COPYING ChangeLog README NEWS TODO
  dodoc doc/*.txt doc/*.conf doc/glosar doc/stats
  docinto html
  dodoc doc/*.html
}







