# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/amavis/amavis-0.2.1-r2.ebuild,v 1.3 2001/05/30 18:24:34 achim Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Virus Scanner"
SRC_URI="http://www.amavis.org/dist/${A}"

HOMEPAGE="http://www.amavis.org"

DEPEND="virtual/glibc
	net-mail/maildrop
	>=net-mail/tnef-0.13
	>=net-mail/vlnx-407e
	net-mail/qmail"

src_compile() {

  ./reconf
  try ./configure --host=${CHOST} --prefix=/usr \
	--with-logdir=/var/log/scanmail \
	--with-virusdir=/var/tmp/virusmails \
	--enable-qmail
  try make
}

src_install() {

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




