# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kth-krb/kth-krb-1.2.ebuild,v 1.7 2004/04/06 03:31:48 vapier Exp $

inherit eutils

DESCRIPTION="Kerberos 4 implementation from KTH"
SRC_URI="ftp://ftp.pdc.kth.se/pub/krb/src/krb4-${PV}.tar.gz"
HOMEPAGE="http://www.pdc.kth.se/kth-krb/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
IUSE="ssl afs"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )
	afs? ( >=net-fs/openafs-1.2.2-r7 )"

S=${WORKDIR}/krb4-${PV}

src_compile() {
	local myconf=""

	epatch ${FILESDIR}/kth-gentoo.patch

	use ssl && myconf="${myconf} --with-openssl=/usr"

	use afs || myconf="${myconf} --without-afs-support"

	./configure \
		--host=${CHOST} \
		--prefix=/usr/athena \
		--sysconfdir=/etc \
		${myconf} || die

	make || die
}

src_install() {
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
