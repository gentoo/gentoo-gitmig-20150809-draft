# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/nss_ldap/nss_ldap-209.ebuild,v 1.1 2003/06/19 07:29:12 raker Exp $

DESCRIPTION="NSS LDAP Module"
HOMEPAGE="http://www.padl.com/OSS/nss_ldap.html"

SRC_URI="http://www.padl.com/download/${P}.tar.gz"
DEPEND=">=net-nds/openldap-1.2.11"
SLOT="0"
IUSE=""
LICENSE="LGPL-2"
KEYWORDS="~x86 ~sparc"

src_compile() {
	./configure \
		--with-ldap-lib=openldap \
		--enable-schema-mapping \
		--enable-rfc2307bis \
		--libdir=/lib || die

	emake || die
}

src_install() {
	dodir /lib
	make DESTDIR=${D} install || die

	insinto /etc
	doins ldap.conf

	dodoc ldap.conf ANNOUNCE NEWS ChangeLog AUTHORS \
		COPYING CVSVersionInfo.txt README nsswitch.ldap \
		LICENSE* 
	docinto docs; dodoc doc/*
}
