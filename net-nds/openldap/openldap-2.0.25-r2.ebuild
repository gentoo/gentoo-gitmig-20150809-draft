# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.0.25-r2.ebuild,v 1.9 2003/05/14 08:56:51 liquidx Exp $

# NOTE : DO NOT REMOVE this from portage because it will break default-1.0 profile

IUSE="ssl tcpd sasl readline ipv6 berkdb gdbm ldap"

S=${WORKDIR}/${P}
DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/${P}.tgz"
HOMEPAGE="http://www.OpenLDAP.org/"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="OPENLDAP"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	tcpd?	  ( >=sys-apps/tcp-wrappers-7.6 )
	ssl?	  ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	sasl?     ( >=dev-libs/cyrus-sasl-1.5.27 )
	berkdb? ( >=sys-libs/db-3.2.9 )
	gdbm?   ( >=sys-libs/gdbm-1.8.0 )"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	gdbm? ( >=sys-libs/gdbm-1.8.0 )"

src_compile() {
	local myconf

	use tcpd \
		&& myconf="${myconf} --enable-wrappers" \
		|| myconf="${myconf} --disable-wrappers"

	use ssl \
		&& myconf="${myconf} --with-tls" \
		|| myconf="${myconf} --without-tls"

	use readline \
		&& myconf="${myconf} --with-readline" \
		|| myconf="${myconf} --without-readline"

	if use berkdb; then
		myconf="${myconf} --enable-ldbm --with-ldbm-api=berkeley"
	elif use gdbm; then
		myconf="${myconf} --enable-ldbm --with-ldbm-api=gdbm"
	elif use ldap-none; then
		myconf="${myconf} --disable-ldbm"
	else
		myconf="${myconf} --enable-ldbm --with-ldbmi-api=auto"
	fi
	use ipv6 && myconf="${myconf} --enable-ipv6" \
		|| myconf="${myconf} --disable-ipv6"
	use sasl && myconf="${myconf} --enable-cyrus-sasl" \
		|| myconf="${myconf} --disable-cyrus-sasl"


	econf \
		--enable-passwd \
		--enable-shell \
		--enable-shared \
		--enable-static \
		--localstatedir=/var/state/openldap \
		--libexecdir=/usr/lib/openldap \
		${myconf} || die "bad configure"

	make depend || die
	make || die
	cd tests ; make || die
}

src_install() {
	einstall \
		sysconfdir=${D}/etc/openldap \
		localstatedir=${D}/var/state/openldap \
		libexecdir=${D}/usr/lib/openldap \
		|| die "install problem"

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
