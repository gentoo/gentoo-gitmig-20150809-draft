# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# Author Joshua Pollak <pardsbane@offthehill.org> (updated 10/31/2001)
# /home/cvsroot/gentoo-x86/net-libs/pam_ldap/pam_ldap-133.ebuild,v 1.1 2001/01/17 21:42:17 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="PAM LDAP Module"
HOMEPAGE="http://www.padl.com/pam_ldap.html"
SRC_URI="ftp://ftp.padl.com/pub/"${A}

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.72
	>=net-nds/openldap-1.2.11"

src_unpack() {
  unpack ${A}
}

src_compile() {                           

  cd ${S}
  try ./configure --host=${CHOST}                     \
                --prefix=/usr                                   \
                --mandir=/usr/share/man                 \
                --infodir=/usr/share/info               \
                --sysconfdir=/etc                               \
                --localstatedir=/var/lib                \
		--with-ldap-lib=openldap

  try emake
}

src_install() {                               
  cd ${S}

  exeinto /lib/security
  doexe pam_ldap.so
  dodoc pam.conf ldap.conf
  dodoc ChangeLog COPYING.* CVSVersionInfo.txt README
  docinto pam.d
  dodoc pam.d/*

  rc-update add nscd default
  /etc/init.d/nscd restart

}
