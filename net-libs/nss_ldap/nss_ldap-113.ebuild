# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/nss_ldap/nss_ldap-113.ebuild,v 1.4 2000/11/02 08:31:52 achim Exp $

P=nss_ldap-113
A=nss_ldap-113.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="NSS LDAP Module"
HOMEPAGE="http://www.padl.com/nss_ldap.html"
SRC_URI="ftp://ftp.padl.com/pub/"${A}

DEPEND=">=sys-libs/glibc-2.1.3
	>=net-nds/openldap-1.2.11"

src_unpack() {
  unpack ${A}
  cd ${S}
  sed -e "s/^NSFLAGS/#NSFLAGS/" \
      -e "s/-lsasl//" \
      -e "s/-O/${CFLAGS}/" Makefile.linux.openldap2 > Makefile
}

src_compile() {                           
  cd ${S}
  try make
}

src_install() {                               
  cd ${S}
  into /
  dolib.so libnss_ldap-2.1.3.so
  preplib /
  into /usr
  doman *.1
  insinto /etc
  doins nsswitch.ldap
  insinto /usr/bin
  insopts -m755
  doins ldaptest.pl
  dodoc ldap.conf ANNOUNCE BUGS ChangeLog CONTRIBUTORS COPYING.LIB
  dodoc CVSVersionInfo.txt IRS README rfc*.txt nsswitch.test
}






