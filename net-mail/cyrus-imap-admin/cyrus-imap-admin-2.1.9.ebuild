# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/cyrus-imap-admin/cyrus-imap-admin-2.1.9.ebuild,v 1.8 2003/06/06 23:58:22 rphillips Exp $

inherit perl-module

S=${WORKDIR}/cyrus-imapd-${PV}

DESCRIPTION="Utilities to administer a Cyrus IMAP Server (includes Perl modules)"
HOMEPAGE="http://asg.web.cmu.edu/cyrus/imapd/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-imapd-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc "

PROVIDE="virtual/imapd"
DEPEND="virtual/glibc
	afs? ( >=net-fs/openafs-1.2.2 )
	snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
    	>=dev-lang/perl-5.6.1
	kerberos? ( >=app-crypt/mit-krb5-1.2.5 )
	>=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/cyrus-sasl-2.1.2
	>=sys-apps/tcp-wrappers-7.6
	dev-perl/ExtUtils-MakeMaker"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch < ${FILESDIR}/config.diff || die "patch failed"

}

src_compile() {

	local myconf
	
	use afs && myconf="--with-afs" \
		|| myconf="--without-afs"

	use snmp && myconf="${myconf} --with-ucdsnmp=/usr" \
		|| myconf="${myconf} --without-ucdsnmp"

	use ssl && myconf="${myconf} --with-openssl=/usr" \
		|| myconf="${myconf} --without-openssl"

	use kerberos && myconf="${myconf} --with-krb --with-auth=krb" \
		|| myconf="${myconf} --without-krb --with-auth=unix"

	econf \
		--enable-listext \
		--with-cyrus-group=mail \
		--enable-netscapehack \
		--with-com_err=yes \
		--with-perl \
		--enable-cyradm \
		${myconf} || die "bad ./configure"

	# make depends break with -f... in CFLAGS
	make depend CFLAGS="" || die "make depend problem"

	cd ${S}/lib
	make || die "compile problem"
	cd ${S}/perl
	make || die "compile problem"

}

src_install () {

	echo "Installation of perl-modules"
	export DESTDIR=${D}
	cd ${S}/perl/imap
		perl-module_src_prep
                perl-module_src_compile
                perl-module_src_install
        cd ${S}/perl/sieve
		perl-module_src_prep
                perl-module_src_compile
                perl-module_src_test
                perl-module_src_install

}
