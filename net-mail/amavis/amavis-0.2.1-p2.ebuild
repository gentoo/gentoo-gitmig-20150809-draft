# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/amavis/amavis-0.2.1-p2.ebuild,v 1.1 2000/08/08 20:58:38 achim Exp $

P=amavis-0.2.1-p2
A=amavis-0.2.1-pre2.tar.gz
S=${WORKDIR}/amavis-0.2.1-pre2
CATEGORY="net-mail"
DESCRIPTION="Virus Scanner"
SRC_URI="http://linuxberg.concepts.nl/files/console/system/"${A}
HOMEPAGE="http://www.amavis.org"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr \
	--with-logdir=/var/log/scanmail \
	--with-virusdir=/var/tmp/virusmails \
	--enable-qmail
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr install
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



