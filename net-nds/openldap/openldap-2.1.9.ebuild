# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.1.9.ebuild,v 1.1 2002/12/19 03:32:01 raker Exp $

IUSE="ssl tcpd readline ipv6 gdbm ldap sasl kerberos odbc"

S=${WORKDIR}/${P}
DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/${P}.tgz"
HOMEPAGE="http://www.OpenLDAP.org/"

SLOT="0"
KEYWORDS="-x86 -ppc"
LICENSE="OPENLDAP"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=sys-libs/readline-4.2a
	>=sys-libs/db-4.0.14
	tcpd?	  ( >=sys-apps/tcp-wrappers-7.6 )
	ssl?	  ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	gdbm?     ( >=sys-libs/gdbm-1.8.0 )
	sasl?     ( >=dev-libs/cyrus-sasl-2.1.7-r3 )
	kerberos? ( >=app-crypt/krb5-1.2.6 )
	odbc?     ( dev-db/unixODBC )"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	gdbm? ( >=sys-libs/gdbm-1.8.0 )"

src_compile() {
	local myconf

	if [ -n "$DEBUG" ]; then
		myconf="--enable-debug"
	else
		myconf="--disable-debug"
	fi

	use sasl \
		&& myconf="${myconf} --with-cyrus-sasl --enable-spasswd" \
		|| myconf="${myconf} --without-cyrus-sasl --disable-spasswd"

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
		--enable-dynamic \
		--enable-lmpasswd \
		--enable-modules \
		--enable-phonetic \
		--enable-rewrite \
		--enable-slp \
		--enable-meta \
		--enable-monitor \
		--enable-passwd \
		--enable-perl \
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

	dodoc ANNOUNCEMENT CHANGES COPYRIGHT README LICENSE
	docinto rfc ; dodoc doc/rfc/*.txt

	exeinto /etc/init.d
	newexe ${FILESDIR}/slapd.rc6 slapd
	newexe ${FILESDIR}/slurpd.rc6 slurpd

}
