# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authors Achim Gottinger <achim@gentoo.org>, Joshua Pollak <pardsbane@offthehill.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/nss_ldap/nss_ldap-174.ebuild,v 1.1 2001/12/02 12:54:54 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="NSS LDAP Module"
HOMEPAGE="http://www.padl.com/nss_ldap.html"
SRC_URI="ftp://ftp.padl.com/pub/${P}.tar.gz"

DEPEND=">=sys-libs/glibc-2.1.3
	>=net-nds/openldap-1.2.11"


src_compile() {

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--enable-extra-optimization || die

	emake UNIX_CAN_BUILD_STATIC=0 \
		OPTIMIZER="${CFLAGS}" || die
}

src_install() {                

	mkdir ${D}/usr
	mkdir ${D}/usr/lib

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	rm ${D}/etc/ldap.conf
	ln -s /etc/openldap/ldap.conf ${D}/etc/ldap.conf

	dodoc ldap.conf ANNOUNCE NEWS ChangeLog AUTHORS COPYING
	dodoc CVSVersionInfo.txt README nsswitch.ldap
}

