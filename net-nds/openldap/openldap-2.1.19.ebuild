# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.1.19.ebuild,v 1.2 2003/05/28 15:43:47 g2boojum Exp $

IUSE="ssl tcpd readline ipv6 gdbm sasl kerberos odbc perl slp"

inherit eutils

DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/${P}.tgz"
HOMEPAGE="http://www.OpenLDAP.org/"

SLOT="0"
KEYWORDS="~x86 -ppc"
LICENSE="OPENLDAP"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/db-4.0.14
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	sasl? ( >=dev-libs/cyrus-sasl-2.1.7-r3 )
	kerberos? ( >=app-crypt/krb5-1.2.6 )
	odbc? ( dev-db/unixODBC )
	slp? ( >=net-libs/openslp-1.0 )
	perl? ( >=dev-lang/perl-5.6 )"
	
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

	local myconf

	# enable debugging to syslog
	myconf="--enable-debug --enable-syslog"
	# enable slapd/slurpd servers
	myconf="${myconf} --enable-ldap"
	myconf="${myconf} --enable-slapd --enable-slurpd"

	use ipv6 \
		&& myconf="${myconf} --enable-ipv6" \
		|| myconf="${myconf} --disable-ipv6"

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

	# slapd options

	use tcpd \
		&& myconf="${myconf} --enable-wrappers" \
		|| myconf="${myconf} --disable-wrappers"

	use odbc \
		&& myconf="${myconf} --enable-sql" \
		|| myconf="${myconf} --disable-sql"
		
	use gdbm \
		&& myconf="${myconf} --enable-ldbm --disable-bdb --with-ldbm-api=gdbm" \
   		|| myconf="${myconf} --enable-ldbm --enable-bdb --with-ldbm-api=berkeley"

	use perl \
		&& myconf="${myconf} --enable-perl" \
		|| myconf="${myconf} --disable-perl"

	use slp \
		&& myconf="${myconf} --enable-slp" \
		|| myconf="${myconf} --disable-slp"

	myconf="${myconf} --enable-dynamic --enable-modules"
	myconf="${myconf} --enable-rewrite --enable-rlookups"
	myconf="${myconf} --enable-meta --enable-monitor"
	myconf="${myconf} --enable-null --enable-shell"
	
	# disabled options
	# --enable-bdb --with-bdb-module=dynamic
	# --enable-dnsserv --with-dnsserv-module=dynamic

	econf \
		--libexecdir=/usr/lib/openldap \
		${myconf} || die "configure failed"

	make depend || die "make depend failed"
	make || die "make failed"
	#cd tests ; make || die "make tests failed"

}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	
	dodoc ANNOUNCEMENT CHANGES COPYRIGHT README LICENSE
	docinto rfc ; dodoc doc/rfc/*.txt

	# make state directories
	for x in data slurp ldbm; do
		keepdir /var/lib/openldap-${x}
		fowners ldap:ldap /var/lib/openldap-${x}
		fperms 0700 /var/lib/openldap-${x}
	done

	# manually remove /var/tmp references in .la
	# because it is packaged with an ancient libtool
	for x in ${D}/usr/lib/lib*.la; do
		sed -i -e "s:-L${S}[/]*libraries::" ${x}
	done

	# change slapd.pid location in configuration file
	keepdir /var/run/openldap
	fowners ldap:ldap /var/run/openldap
	fperms 0755 /var/run/openldap
	sed -i -e "s:/var/lib/slapd.pid:/var/run/openldap/slapd.pid:" ${D}/etc/openldap/slapd.conf
	sed -i -e "s:/var/lib/slapd.pid:/var/run/openldap/slapd.pid:" ${D}/etc/openldap/slapd.conf.default
	fowners root:ldap /etc/openldap/slapd.conf
	fperms 0640 /etc/openldap/slapd.conf
	fowners root:ldap /etc/openldap/slapd.conf.default
	fperms 0640 /etc/openldap/slapd.conf.default
	
	# install our own init scripts
	exeinto /etc/init.d
	newexe ${FILESDIR}/2.0/slapd slapd
	newexe ${FILESDIR}/2.0/slurpd slurpd
	insinto /etc/conf.d
	newins ${FILESDIR}/2.0/slapd.conf slapd.conf

}
