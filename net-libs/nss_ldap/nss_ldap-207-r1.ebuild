# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/nss_ldap/nss_ldap-207-r1.ebuild,v 1.5 2004/01/30 06:55:05 raker Exp $

inherit fixheadtails
DESCRIPTION="NSS LDAP Module"
HOMEPAGE="http://www.padl.com/OSS/nss_ldap.html"

SRC_URI="ftp://ftp.padl.com/pub/${P}.tar.gz"
DEPEND=">=net-nds/openldap-1.2.11"
SLOT="0"
IUSE=""
LICENSE="LGPL-2"
KEYWORDS="x86 sparc"

src_unpack() {
	unpack ${A}
	# fix head/tail stuff
	ht_fix_file ${S}/Makefile.am ${S}/Makefile.in ${S}/depcomp ${S}/config.guess
}

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
