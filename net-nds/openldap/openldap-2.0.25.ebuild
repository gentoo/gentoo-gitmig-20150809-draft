# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.0.25.ebuild,v 1.2 2002/07/26 12:22:36 raker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/${P}.tgz"
HOMEPAGE="http://www.OpenLDAP.org/"

SLOT="0"
KEYWORDS="x86"
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

	use tcpd && myconf="${myconf} --enable-wrappers"
	use ssl && myconf="${myconf} --with-tls"
	use readline && myconf="${myconf} --with-readline"
	use readline || myconf="${myconf} --without-readline"
	use gdbm && myconf="${myconf} --enable-ldbm --with-ldbm-api=gdbm"
	use gdbm || myconf="${myconf} --disable-ldbm"
	use ipv6 && myconf="${myconf} --enable-ipv6"
	use sasl && myconf="${myconf} --enable-cyrus-sasl" 


	./configure --host=${CHOST} \
		--enable-passwd \
		--enable-shell \
		--enable-shared \
		--enable-static \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
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
		localstatedir=${D}/var \
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

	dodir /var/state/openldap
	mv ${D}/var/state/openldap-* ${D}/var/state/openldap
}
