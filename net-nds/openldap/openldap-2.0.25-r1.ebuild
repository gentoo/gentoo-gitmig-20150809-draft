# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.0.25-r1.ebuild,v 1.9 2003/06/22 11:33:37 liquidx Exp $

### WARNING !! Do not remove openldap 2.0.25 or else it will break for 
####           default-1.0 profile!

IUSE="ssl ipv6 sasl readline tcpd gdbm"

S=${WORKDIR}/${P}
DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/${P}.tgz"
HOMEPAGE="http://www.OpenLDAP.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="OPENLDAP"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	tcpd?	  ( >=sys-apps/tcp-wrappers-7.6 )
	ssl?	  ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	gdbm?	  ( >=sys-libs/gdbm-1.8.0 )
	sasl?     ( >=dev-libs/cyrus-sasl-1.5.27 )"

RDEPEND="virtual/glibc
        >=sys-libs/ncurses-5.1
        gdbm? ( >=sys-libs/gdbm-1.8.0 )"

src_compile() {
	local myconf

	use tcpd && myconf="${myconf} --enable-wrappers" \
		|| myconf="${myconf} --disable-wrappers"
	use ssl && myconf="${myconf} --with-tls" \
		|| myconf="${myconf} --without-tls"
	use readline && myconf="${myconf} --with-readline" \
		|| myconf="${myconf} --without-readline"
	use gdbm && myconf="${myconf} --enable-ldbm --with-ldbm-api=gdbm" \
		|| myconf="${myconf} --disable-ldbm"
	use ipv6 && myconf="${myconf} --enable-ipv6" \
		|| myconf="${myconf} --disable-ipv6"
	use sasl && myconf="${myconf} --enable-cyrus-sasl" \
		|| myconf="${myconf} --disable-cyrus-sasl"


	./configure --host=${CHOST} \
		--enable-passwd \
		--enable-shell \
		--enable-shared \
		--enable-static \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state/openldap \
		--mandir=/usr/share/man \
		--libexecdir=/usr/lib/openldap \
		${myconf} || die "bad configure"

	make depend || die
	make || die
	cd tests ; make || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc/openldap \
		localstatedir=${D}/var/state/openldap \
		mandir=${D}/usr/share/man \
		libexecdir=${D}/usr/lib/openldap \
		install || die "install problem"

	#fix ${D} in manpages
	cd ${S}/doc/man
	make DESTDIR=${D} clean all install || die "install doc problem"
	cd ${S}

	dodoc ANNOUNCEMENT CHANGES COPYRIGHT README LICENSE
	docinto rfc ; dodoc doc/rfc/*.txt
	docinto devel ; dodoc doc/devel/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/slapd.rc6 slapd
	newexe ${FILESDIR}/slurpd.rc6 slurpd

	cd ${D}/etc/openldap
	for i in *
	do
		dosed $i
	done
}
