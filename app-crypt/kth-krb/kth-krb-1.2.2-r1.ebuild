# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kth-krb/kth-krb-1.2.2-r1.ebuild,v 1.8 2004/04/06 03:31:30 vapier Exp $

inherit eutils

DESCRIPTION="Kerberos 4 implementation from KTH"
HOMEPAGE="http://www.pdc.kth.se/kth-krb/"
SRC_URI="ftp://ftp.pdc.kth.se/pub/krb/src/krb4-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ia64 amd64"
IUSE="ssl afs"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )
	!amd64? ( afs? ( >=net-fs/openafs-1.2.2-r7 ) )"

S=${WORKDIR}/krb4-${PV}

src_compile() {
	local myconf=""
	echo ${PORTAGE_TMPDIR}

	epatch ${FILESDIR}/kth-gentoo.patch
	epatch ${FILESDIR}/kth-gentoo-ssl.patch

	use ssl && myconf="${myconf} --with-openssl=/usr"

	use afs || myconf="${myconf} --without-afs-support"

	econf \
		--prefix=/usr/athena \
		${myconf} || die

	make || die
}

src_install() {
	make prefix=${D}/usr/athena \
		sysconfdir=${D}/etc \
		install || die

	# Doesn't get install otherwise (for some reason, look into this).
	if use ssl ; then
		cd ${S}/lib/des

		make prefix=${D}/usr/athena \
	 		install || die

		cd ${S}
	fi

	dodir /etc/env.d
	cp ${FILESDIR}/02kth-krb ${D}/etc/env.d

	dodoc ChangeLog README NEWS PROBLEMS TODO

	# rphillips: cludge to fix the paths
	einfo "Fixing /usr/athena/lib library paths"
	cd ${D}/usr/athena/lib
	sed -i 's:${D}/::g' *.la
}
