# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.0.27-r5.ebuild,v 1.1 2004/01/28 04:38:47 robbat2 Exp $

inherit eutils

IUSE="ssl tcpd readline ipv6 berkdb gdbm kerberos odbc"

DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/${P}.tgz"
HOMEPAGE="http://www.OpenLDAP.org/"

SLOT="0"
KEYWORDS="x86 ~ppc alpha sparc ia64"
LICENSE="OPENLDAP"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-apps/sed-4
	berkdb?   ( =sys-libs/db-3* )
	tcpd?	  ( >=sys-apps/tcp-wrappers-7.6 )
	ssl?	  ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	gdbm?     ( >=sys-libs/gdbm-1.8.0 )
	kerberos? ( >=app-crypt/mit-krb5-1.2.6 )
	odbc?     ( dev-db/unixODBC )"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	if [ "${SASL1}" != "yes" ]; then
		ewarn ""
		ewarn "For linking with SASLv1..."
		ewarn "emerge cyrus-sasl-1.5.27-r6 (or newest 1.x series build)"
		ewarn "SASL1=yes emerge net-nds/openldap"
		ewarn ""
		sleep 2
	else
		ewarn ""
		ewarn "You are building ${PVR} linking to SASLv1"
		ewarn ""
	fi
}

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

	# According to MDK, the link order needs to be changed so that
	# on systems w/ MD5 passwords the system crypt library is used
	# (the net result is that "passwd" can be used to change ldap passwords w/
	#  proper pam support)
	sed -ie 's/$(SECURITY_LIBS) $(LDIF_LIBS) $(LUTIL_LIBS)/$(LUTIL_LIBS) $(SECURITY_LIBS) $(LDIF_LIBS)/' ${S}/servers/slapd/Makefile.in

	# rfc2252 has some missing characters...
	epatch ${FILESDIR}/rfc2252-bork.patch
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

	use berkdb \
		&& myconf="${myconf} --enable-ldbm --with-ldbm-api=berkeley"

	# only set gdbm api if berkdb is not in USE
	use gdbm && [ ! `use berkdb` ] \
		&& myconf="${myconf} --enable-ldbm --with-ldbm-api=gdbm" \
		|| myconf="${myconf} --enable-ldbm --with-ldbm-api=berkeley"

	if [ "${SASL1}" = "yes" ]; then
		myconf="${myconf} --with-cyrus-sasl"
	else
		myconf="${myconf} --without-cyrus-sasl"
	fi

	econf \
		--libexecdir=/usr/lib/openldap \
		--enable-crypt \
		--enable-modules \
		--enable-phonetic \
		--enable-dynamic \
		--enable-ldap \
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
	if [ ! -e /etc/openldap/ssl/ldap.pem ]; then
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

	if [ "${SASL1}" != "yes" ]; then
		einfo ""
		einfo "For linking with SASLv1..."
		einfo "emerge cyrus-sasl-1.5.27-r6 (or newest 1.x series build)"
		einfo "SASL1=yes emerge net-nds/openldap"
		einfo ""
	fi

	ewarn ""
	ewarn "slapd is no longer running as root!"
	ewarn "If you have upgraded from a previous ebuild you may find problems"
	ewarn "Make sure your ldap databases are chown ldap:ldap"
	ewarn "See http://bugs.gentoo.org/show_bug.cgi?id=24790 for more info"
	ewarn ""
}
