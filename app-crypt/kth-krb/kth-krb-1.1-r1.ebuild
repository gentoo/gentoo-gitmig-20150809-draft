# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kth-krb/kth-krb-1.1-r1.ebuild,v 1.3 2002/07/25 15:31:25 seemant Exp $

S=${WORKDIR}/krb4-${PV}
DESCRIPTION="Kerberos 4 implementation from KTH"
SRC_URI="ftp://ftp.pdc.kth.se/pub/krb/src/krb4-${PV}.tar.gz"
HOMEPAGE="http://www.pdc.kth.se/kth-krb/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )
	afs? ( >=net-fs/openafs-1.2.2-r7 )"

src_compile() {
	local myconf=""

	use ssl && myconf="${myconf} --with-openssl=/usr"

	use afs || myconf="${myconf} --without-afs-support"

	./configure \
		--host=${CHOST} \
		--prefix=/usr/athena \
		--sysconfdir=/etc \
		${myconf} || die

	emake || die
}

src_install () {
	make prefix=${D}/usr/athena \
		sysconfdir=${D}/etc \
		install || die

	# Doesn't get install otherwise (for some reason, look into this).
	if [ "`use ssl`" ] ; then
		cd ${S}/lib/des

		make prefix=${D}/usr/athena \
	 		install || die

		cd ${S}
	fi

	dodir /etc/env.d
	cp ${FILESDIR}/02kth-krb ${D}/etc/env.d

	dodoc COPYRIGHT ChangeLog README NEWS PROBLEMS TODO
}
