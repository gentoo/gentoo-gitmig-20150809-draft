# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/nss_ldap/nss_ldap-207.ebuild,v 1.1 2003/05/28 20:54:57 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="NSS LDAP Module"
HOMEPAGE="http://www.padl.com/OSS/nss_ldap.html"
SRC_URI="ftp://ftp.padl.com/pub/${P}.tar.gz"

DEPEND=">=net-nds/openldap-1.2.11"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc"

src_compile() {

	econf \
		--enable-schema-mapping \
		--enable-rfc2307bis \
		--enable-extra-optimization || die

	emake UNIX_CAN_BUILD_STATIC=0 \
		OPTIMIZER="${CFLAGS}" || die
}

src_install() {                

	dodir /usr/lib

	make \
		DESTDIR=${D} \
		install || die

	insinto /etc/openldap
	doins ldap.conf
	dosym /etc/openldap/ldap.conf /etc/ldap.conf

	dodoc ldap.conf ANNOUNCE NEWS ChangeLog AUTHORS COPYING
	dodoc CVSVersionInfo.txt README nsswitch.ldap
}
