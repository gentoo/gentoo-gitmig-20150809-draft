# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/whois/whois-4.5.2.ebuild,v 1.1 2001/01/24 04:38:59 jerry Exp $

A=whois_4.5.2.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Whois Client"
SRC_URI="http://www.linux.it/~md/software/${A}"

DEPEND=">=sys-devel/perl-5
	>=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s/-O2/$CFLAGS/" Makefile.orig > Makefile
  cd po
  cp Makefile Makefile.orig
  sed -e "s:/usr/bin/install:/bin/install:" Makefile.orig > Makefile

}
src_compile() {                           
  cd ${S}
  try make
  try make mkpasswd
}

src_install() {                               
  cd ${S}
  dodir /usr/bin
  dodir /usr/man/man1
  dodir /usr/share/locale
  try make BASEDIR=${D} prefix=/usr install
  prepman
  dobin mkpasswd
  doman mkpasswd.1
  dodoc README TODO debian/changelog debian/copyright

}




