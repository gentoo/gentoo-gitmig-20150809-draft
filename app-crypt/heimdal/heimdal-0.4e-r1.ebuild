# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-0.4e-r1.ebuild,v 1.3 2002/07/11 06:30:11 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Kerberos 5 implementation from KTH"
SRC_URI="ftp://ftp.pdc.kth.se/pub/${PN}/src/${P}.tar.gz"
HOMEPAGE="http://www.pdc.kth.se/heimdal/"

DEPEND="virtual/glibc
	>=app-crypt/kth-krb-1.1-r1
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	berkdb? ( sys-libs/db )"

src_compile() {
	local myconf

	if [ "`use ssl`" ] ; then
		myconf="--with-openssl=/usr"
	fi

	if [ "`use ldap`" ] ; then
		myconf="${myconf} --with-open-ldap=/usr"
	fi

	if [ -z "`use ipv6`" ] ; then 
		myconf="${myconf} --without-ipv6"
	fi

	if [ -z "`use berkdb`" ] ; then
		myconf="${myconf} --without-berkely-db"
	fi

	./configure --host=${CHOST} \
			--prefix=/usr/heimdal \
			--sysconfdir=/etc \
			--with-krb4=/usr/athena \
			${myconf} || die

	emake || die
}

src_install () {
	make prefix=${D}/usr/heimdal \
		sysconfdir=${D}/etc \
		install || die

	dodir /etc/env.d
	cp ${FILESDIR}/01heimdal ${D}/etc/env.d

	dodoc COPYRIGHT ChangeLog README NEWS PROBLEMS TODO
}



