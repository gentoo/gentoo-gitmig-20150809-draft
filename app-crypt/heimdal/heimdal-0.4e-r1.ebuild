# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-0.4e-r1.ebuild,v 1.15 2004/02/17 22:09:15 agriffis Exp $

DESCRIPTION="Kerberos 5 implementation from KTH"
SRC_URI="ftp://ftp.pdc.kth.se/pub/heimdal/src/${P}.tar.gz"
HOMEPAGE="http://www.pdc.kth.se/heimdal/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 -sparc "
IUSE="ssl berkdb ipv6 ldap"

DEPEND=">=app-crypt/kth-krb-1.1-r1
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	berkdb? ( sys-libs/db )"

src_compile() {
	local myconf

	use ssl && myconf="--with-openssl=/usr"

	use ldap && myconf="${myconf} --with-open-ldap=/usr"

	use ipv6 || myconf="${myconf} --without-ipv6"

	use berkdb || myconf="${myconf} --without-berkely-db"

	./configure --host=${CHOST} \
		--prefix=/usr/heimdal \
		--sysconfdir=/etc \
		--with-krb4=/usr/athena \
		${myconf} || die

	make || die
}

src_install() {
	make prefix=${D}/usr/heimdal \
		sysconfdir=${D}/etc \
		install || die

	dodir /etc/env.d
	cp ${FILESDIR}/01heimdal ${D}/etc/env.d

	dodoc COPYRIGHT ChangeLog README NEWS PROBLEMS TODO
}
