# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-0.5.1.ebuild,v 1.8 2003/12/16 01:06:51 weeve Exp $

DESCRIPTION="Kerberos 5 implementation from KTH"
SRC_URI="ftp://ftp.pdc.kth.se/pub/heimdal/src/${P}.tar.gz"
HOMEPAGE="http://www.pdc.kth.se/heimdal/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 -sparc "
IUSE="ssl ldap berkdb ipv6"

DEPEND=">=app-crypt/kth-krb-1.2.1
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	berkdb? ( sys-libs/db )"

src_unpack() {
	unpack ${A}

	cd ${S}/lib/krb5
	sed -i "s:LIB_crypt = @LIB_crypt@:LIB_crypt = -lssl @LIB_crypt@:g" Makefile.in
}

src_compile() {
	local myconf

	use ssl && myconf="--with-openssl=/usr" || myconf="--without-openssl"

	use ldap && myconf="${myconf} --with-open-ldap=/usr"

	use ipv6 || myconf="${myconf} --without-ipv6"

	use berkdb || myconf="${myconf} --without-berkely-db"

	./configure --host=${CHOST} \
		--prefix=/usr/heimdal \
		--sysconfdir=/etc \
		--with-krb4=/usr/athena \
		${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr/heimdal \
		sysconfdir=${D}/etc \
		install || die

	dodir /etc/env.d
	cp ${FILESDIR}/01heimdal ${D}/etc/env.d

	dodoc COPYRIGHT ChangeLog README NEWS PROBLEMS TODO
}
