# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/amavis/amavis-0.2.1_p3.ebuild,v 1.1 2000/10/05 01:32:51 achim Exp $

P=amavis-0.2.1-p3
A="amavis-0.2.1-pre3.tar.gz configure.in.patch scanmails.in.patch"
S=${WORKDIR}/amavis-0.2.1-pre3
DESCRIPTION="Virus Scanner"
SRC_URI="http://linuxberg.concepts.nl/files/console/system/${A}
	 http://www.amavis.org/configure.in.patch
	 http://www.amavis.org/scanmails.in.patch"

HOMEPAGE="http://www.amavis.org"

src_unpack() {
  unpack amavis-0.2.1-pre3.tar.gz
  cd ${S}
  patch -p0 < ${DISTDIR}/configure.in.patch
  cd ${S}/src/scanmails
  patch -p0 < ${DISTDIR}/scanmails.in.patch
}
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
  dodoc doc/*.gif doc/*.html
  dodir /var/log/scanmail
  dodir /var/tmp/virusmails
  chmod 777 ${D}/var/log/scanmail
  chmod 777 ${D}/var/tmp/virusmails

}



