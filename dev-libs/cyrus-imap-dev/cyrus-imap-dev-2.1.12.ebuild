# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cyrus-imap-dev/cyrus-imap-dev-2.1.12.ebuild,v 1.8 2004/01/20 18:33:44 max Exp $

inherit eutils

DESCRIPTION="Developer support for the Cyrus IMAP Server"
HOMEPAGE="http://asg.web.cmu.edu/cyrus/imapd/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/OLD-VERSIONS/imap/cyrus-imapd-${PV}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc "
DEPEND="virtual/glibc
	afs? ( >=net-fs/openafs-1.2.2 )
	snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	kerberos? ( >=app-crypt/mit-krb5-1.2.5 )
	>=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/cyrus-sasl-2.1.12
	>=sys-apps/tcp-wrappers-7.6"
S=${WORKDIR}/cyrus-imapd-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	# add libwrap defines as we don't have a dynamicly linked library.
	epatch ${FILESDIR}/${P}-libwrap.patch
	# when linking with rpm, you need to link with more libraries.
	cp configure configure.orig
	sed -e "s:lrpm:lrpm -lrpmio -lrpmdb:" \
		< configure.orig > configure
}

src_compile() {
	local myconf

	use afs && myconf="--with-afs" \
		|| myconf="--without-afs"

	use snmp && myconf="${myconf} --with-ucdsnmp=/usr" \
		|| myconf="${myconf} --without-ucdsnmp"

	use ssl && myconf="${myconf} --with-openssl=/usr" \
		|| myconf="${myconf} --without-openssl"

	#use kerberos && myconf="${myconf} --with-krb=/usr/athena --with-auth=krb --enable-gssapi" \
	#	|| myconf="${myconf} --without-krb --with-auth=unix --disable-gssapi"
	# As cyrus-sasl-2.1.12 doesn't appear to compile in krb4 support
	# (neither did previous versions) only support krb5
	use kerberos && myconf="${myconf} --with-auth=krb --enable-gssapi" \
		|| myconf="${myconf} --without-krb --with-auth=unix --disable-gssapi"

	econf \
		--enable-listext \
		--with-cyrus-group=mail \
		--enable-netscapehack \
		--with-com_err=yes \
		--without-perl \
		--disable-cyradm \
		--with-libwrap=/usr \
		${myconf}

	# make depends break with -f... in CFLAGS
	make depend CFLAGS="" || die "make depend problem"

	cd ${S}/lib
	make || die "compile problem"
	cd ${S}/acap
	make || die "compile problem"
}

src_install() {
	dodoc COPYRIGHT README*
	cd ${S}/lib
	dodir /usr/include/cyrus
	emake DESTDIR=${D} install || die "compile problem"
	cd ${S}/acap
	emake DESTDIR=${D} install || die "compile problem"
}
