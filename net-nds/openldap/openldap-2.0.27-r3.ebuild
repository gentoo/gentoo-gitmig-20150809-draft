# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.0.27-r3.ebuild,v 1.3 2003/05/12 04:02:28 weeve Exp $

inherit eutils

IUSE="ssl tcpd readline ipv6 gdbm kerberos odbc"

DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/${P}.tgz"
HOMEPAGE="http://www.OpenLDAP.org/"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"
LICENSE="OPENLDAP"

DEPEND=">=sys-libs/ncurses-5.1
	=sys-libs/db-3*
	tcpd?	  ( >=sys-apps/tcp-wrappers-7.6 )
	ssl?	  ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	gdbm?     ( >=sys-libs/gdbm-1.8.0 )
	kerberos? ( >=app-crypt/krb5-1.2.6 )
	odbc?     ( dev-db/unixODBC )"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	gdbm? ( >=sys-libs/gdbm-1.8.0 )"

MAKEOPTS="${MAKEOPTS} -j1"

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


src_unpack() {
	unpack ${A}
	cd ${S}
	# never worked anyway ?
	epatch ${FILESDIR}/kerberos-2.0.diff.bz2
	# force the use of db3 only, db4 has api breakages
	epatch ${FILESDIR}/${P}-db3-gentoo.patch
}

src_compile() {
	local myconf

	# must enable debug for syslog'ing (#16131)
	myconf="--enable-debug --enable-syslog"

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

	use ipv6 \
		&& myconf="${myconf} --enable-ipv6" \
		|| myconf="${myconf} --disable-ipv6"

	use odbc \
		&& myconf="${myconf} --enable-sql" \
		|| myconf="${myconf} --disable-sql"

	use gdbm \
		&& myconf="${myconf} --enable-ldbm --with-ldbm-api=gdbm" \
   		|| myconf="${myconf} --enable-ldbm --with-ldbm-api=berkeley"


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
		${myconf} || die "configure failed"

	emake depend || die "make depend failed"

	emake || die "make failed"

	cd tests ; make || die "make tests failed"

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
