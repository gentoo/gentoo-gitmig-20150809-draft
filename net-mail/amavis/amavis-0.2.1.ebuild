# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/amavis/amavis-0.2.1.ebuild,v 1.1 2000/10/31 17:42:09 achim Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Virus Scanner"
SRC_URI="http://www.amavis.org/dist/${A}"

HOMEPAGE="http://www.amavis.org"

src_compile() {                           
  cd ${S}
  ./reconf
  try ./configure --host=${CHOST} --prefix=/usr \
	--with-logdir=/var/log/scanmail \
	--with-virusdir=/var/tmp/virusmails \
	--enable-qmail
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  into /usr
  dodoc AUTHORS BUGS COPYING ChangeLog FAQ HINTS NEWS README* TODO
  dodoc doc/amavis.txt
  docinto html
  dodoc doc/*.png doc/*.html
  dodir /var/log/scanmail
  dodir /var/tmp/virusmails
  chmod 777 ${D}/var/log/scanmail
  chmod 777 ${D}/var/tmp/virusmails

}




