# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.0.27-r2.ebuild,v 1.5 2003/04/17 16:53:27 agriffis Exp $

DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/${P}.tgz"
HOMEPAGE="http://www.OpenLDAP.org/"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
LICENSE="OPENLDAP"
IUSE="ssl tcpd readline ipv6 gdbm ldap kerberos odbc"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=sys-libs/db-3
	tcpd?	  ( >=sys-apps/tcp-wrappers-7.6 )
	ssl?	  ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	gdbm?     ( >=sys-libs/gdbm-1.8.0 )
	kerberos? ( >=app-crypt/krb5-1.2.6 )
	odbc?     ( dev-db/unixODBC )"
RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	gdbm? ( >=sys-libs/gdbm-1.8.0 )"

inherit eutils

pkg_preinst() {
        if ! grep -q ^ldap: /etc/group
        then
                groupadd -g 439 ldap || die "problem adding group ldap"
        fi
        if ! grep -q ^ldap: /etc/passwd
        then
                useradd -u 439 -d /usr/lib/openldap -g ldap -s /dev/null ldap \
                        || die "problem adding user ldap"
        fi
}


src_compile() {

	epatch ${FILESDIR}/kerberos-2.0.diff.bz2

	local myconf

	if [ -n "$DEBUG" ]; then
		myconf="--enable-debug"
	else
		myconf="--disable-debug"
	fi

	use kerberos \
		&& myconf="${myconf} --with-kerberos --enable-kpasswd" \
		|| myconf="${myconf} --without-kerberos --disable-kpasswd"

	use readline \
		&& myconf="${myconf} --with-readline" \
		|| myconf="${myconf} --without-readline"

	use ssl \
		&& myconf="${myconf} --with-tls" \
		|| myconf="${myconf} --without-tls"

	use tcpd \
		&& myconf="${myconf} --enable-wrappers" \
		|| myconf="${myconf} --disable-wrappers"

	use ipv6 && myconf="${myconf} --enable-ipv6" \
		|| myconf="${myconf} --disable-ipv6"

	use odbc && myconf="${myconf} --enable-sql" \
		|| myconf="${myconf} --disable-sql"

	econf \
		--libexecdir=/usr/lib/openldap \
		--enable-crypt \
		--enable-modules \
		--enable-phonetic \
		--enable-dynamic \
		--enable-ldap \
		--without-cyrus-sasl \
		--disable-spasswd \
		--enable-passwd \
		--enable-shell \
		--enable-slurpd \
		--enable-ldbm \
		--with-ldbm-api=auto \
		${myconf} || die "configure failed"

	make depend || die "make depend failed"

	make || die "make failed"

	cd tests ; make || die "make tests failed"

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	chown ldap:ldap ${D}/etc/openldap/slapd.conf
	dodir /var/lib/openldap-data
	chown ldap:ldap ${D}var/lib/openldap-data

	dodoc ANNOUNCEMENT CHANGES COPYRIGHT README LICENSE
	docinto rfc ; dodoc doc/rfc/*.txt

	exeinto /etc/init.d
	newexe ${FILESDIR}/slapd-2.1-r1.rc6 slapd
	newexe ${FILESDIR}/slurpd-2.1.rc6 slurpd
	insinto /etc/conf.d
	newins ${FILESDIR}/slapd-2.1.conf slapd.conf

}
