# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.1.22.ebuild,v 1.9 2003/12/23 02:56:02 robbat2 Exp $

inherit eutils

DESCRIPTION="LDAP suite of application and development tools"
HOMEPAGE="http://www.OpenLDAP.org/"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/${P}.tgz"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha amd64"
IUSE="berkdb crypt gdbm ipv6 kerberos odbc perl readline sasl slp ssl tcpd"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-apps/sed-4
	berkdb? ( >=sys-libs/db-4.1 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	sasl? ( >=dev-libs/cyrus-sasl-2.1.7-r3 )
	kerberos? ( >=app-crypt/mit-krb5-1.2.6 )
	odbc? ( dev-db/unixODBC )
	slp? ( >=net-libs/openslp-1.0 )
	perl? ( >=dev-lang/perl-5.6 )"

pkg_preinst() {
	enewgroup ldap 439
	enewuser ldap 439 /dev/null /usr/lib/openldap ldap
}

src_unpack() {
	unpack ${A}
	# According to MDK, the link order needs to be changed so that
	# on systems w/ MD5 passwords the system crypt library is used
	# (the net result is that "passwd" can be used to change ldap passwords w/
	#  proper pam support)
	sed -ie 's/$(SECURITY_LIBS) $(LDIF_LIBS) $(LUTIL_LIBS)/$(LUTIL_LIBS) $(SECURITY_LIBS) $(LDIF_LIBS)/' ${S}/servers/slapd/Makefile.in
}

src_compile() {
	local myconf

	# enable debugging to syslog
	myconf="--enable-debug --enable-syslog"
	# enable slapd/slurpd servers
	myconf="${myconf} --enable-ldap"
	myconf="${myconf} --enable-slapd --enable-slurpd"

	myconf="${myconf} `use_enable crypt`"
	myconf="${myconf} `use_enable ipv6`"
	myconf="${myconf} `use_with sasl cyrus-sasl` `use_enable sasl spasswd`"
	myconf="${myconf} `use_with kerberos` `use_enable kerberos kpasswd`"
	myconf="${myconf} `use_with readline`"
	myconf="${myconf} `use_with ssl tls`"
	myconf="${myconf} `use_enable tcpd wrappers`"
	myconf="${myconf} `use_enable odbc sql`"
	myconf="${myconf} `use_enable perl`"
	myconf="${myconf} `use_enable slp`"

	use berkdb \
		&& myconf="${myconf} --enable-ldbm --enable-bdb --with-ldbm-api=berkeley"

	# only turn off bdb if berkdb is not in USE
	use gdbm && [ ! `use berkdb` ] \
		&& myconf="${myconf} --enable-ldbm --disable-bdb --with-ldbm-api=gdbm" \
		|| myconf="${myconf} --enable-ldbm --enable-bdb --with-ldbm-api=berkeley"

	myconf="${myconf} --enable-dynamic --enable-modules"
	myconf="${myconf} --enable-rewrite --enable-rlookups"
	myconf="${myconf} --enable-meta --enable-monitor"
	myconf="${myconf} --enable-null --enable-shell"
	myconf="${myconf} --enable-local --enable-proctitle"

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
	sed -i -e "s:/var/lib/slapd.args:/var/run/openldap/slapd.args:" ${D}/etc/openldap/slapd.conf
	sed -i -e "s:/var/lib/slapd.args:/var/run/openldap/slapd.args:" ${D}/etc/openldap/slapd.conf.default
	fowners root:ldap /etc/openldap/slapd.conf
	fperms 0640 /etc/openldap/slapd.conf
	fowners root:ldap /etc/openldap/slapd.conf.default
	fperms 0640 /etc/openldap/slapd.conf.default

	# install our own init scripts
	exeinto /etc/init.d
	newexe ${FILESDIR}/2.0/slapd slapd
	newexe ${FILESDIR}/2.0/slurpd slurpd
	insinto /etc/conf.d
	newins ${FILESDIR}/2.0/slapd.conf slapd

	# install MDK's ssl cert script
	dodir /etc/openldap/ssl
	exeinto /etc/openldap/ssl
	doexe ${FILESDIR}/gencert.sh

}

pkg_postinst() {
	# make a self-signed ssl cert (if there isn't one there already)
	if [ ! -e /etc/openldap/ssl/ldap.pem ]
	then
		cd /etc/openldap/ssl
		yes "" | sh gencert.sh
		chmod 640 ldap.pem
		chown root:ldap ldap.pem
	fi

	# Since moving to running openldap as user ldap there are some
	# permissions problems with directories and files.
	# Let's make sure these permissions are correct.
	chown ldap:ldap /var/run/openldap
	chmod 0755 /var/run/openldap
	chown root:ldap /etc/openldap/slapd.conf
	chmod 0640 /etc/openldap/slapd.conf
	chown root:ldap /etc/openldap/slapd.conf.default
	chmod 0640 /etc/openldap/slapd.conf.default
	chown ldap:ldap /var/lib/openldap-{data,ldbm,slurp}
}
