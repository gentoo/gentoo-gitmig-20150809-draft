# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/pam_ldap/pam_ldap-61-r1.ebuild,v 1.1 2000/08/08 19:27:19 achim Exp $

P=pam_ldap-61
A=pam_ldap.tgz
S=${WORKDIR}/${P}
CATEGORY="net-libs"
DESCRIPTION="PAM LDAP Module"
HOMEPAGE="http://www.padl.com/pam_ldap.html"
SRC_URI="ftp://ftp.padl.com/pub/"${A}

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  touch NEWS
  touch AUTHORS
  ./configure --host=${CHOST} --prefix=/usr --with-ldap-lib=openldap
  make
}

src_install() {                               
  cd ${S}
  exeinto /usr/lib/security
  doexe pam_ldap.so
  dodoc pam.conf ldap.conf
  dodoc ChangeLog COPYING.* CVSVersionInfo.txt README
  docinto pam.d
  dodoc pam.d/*
}





