# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/bind/bind-9.6.2_p2-r1.ebuild,v 1.1 2010/09/23 21:05:25 idl0r Exp $

EAPI="3"

inherit eutils autotools toolchain-funcs flag-o-matic

MY_PV="${PV/_p/-P}"
MY_P="${PN}-${MY_PV}"

SDB_LDAP_VER="1.1.0"

GEOIP_PV=1.3
GEOIP_SRC_URI_BASE="http://bind-geoip.googlecode.com/"
GEOIP_P="bind-geoip-${GEOIP_PV}"

DESCRIPTION="BIND - Berkeley Internet Name Domain - Name Server"
HOMEPAGE="http://www.isc.org/software/bind"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${MY_PV}/${MY_P}.tar.gz
	doc? ( mirror://gentoo/dyndns-samples.tbz2 )
	geoip? ( ${GEOIP_SRC_URI_BASE}/files/${GEOIP_P}-readme.txt
			 ${GEOIP_SRC_URI_BASE}/files/${GEOIP_P}.patch )"
#	sdb-ldap? ( mirror://gentoo/bind-sdb-ldap-${SDB_LDAP_VER}.tar.bz2 )

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="ssl ipv6 doc dlz postgres berkdb mysql odbc ldap selinux idn threads
	resolvconf urandom xml geoip gssapi" # sdb-ldap

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6g )
	mysql? ( >=virtual/mysql-4.0 )
	odbc? ( >=dev-db/unixODBC-2.2.6 )
	ldap? ( net-nds/openldap )
	idn? ( net-dns/idnkit )
	postgres? ( dev-db/postgresql-base )
	threads? ( >=sys-libs/libcap-2.1.0 )
	xml? ( dev-libs/libxml2 )
	geoip? ( >=dev-libs/geoip-1.4.6 )
	gssapi? ( virtual/krb5 )"
#	sdb-ldap? ( net-nds/openldap )

RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-bind )
	resolvconf? ( net-dns/openresolv )
	sys-process/psmisc"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use threads && {
		ewarn
		ewarn "If you're in vserver enviroment, you're probably want to"
		ewarn "disable threads support because of linux capabilities dependency"
		ewarn
	}

	ebegin "Creating named group and user"
	enewgroup named 40
	enewuser named 40 -1 /etc/bind named
	eend ${?}
}

src_prepare() {
	# bug 278364 (workaround)
	epatch "${FILESDIR}/${PN}-9.6.1-parallel.patch"

	# Adjusting PATHs in manpages
	for i in bin/{named/named.8,check/named-checkconf.8,rndc/rndc.8} ; do
		sed -i \
			-e 's:/etc/named.conf:/etc/bind/named.conf:g' \
			-e 's:/etc/rndc.conf:/etc/bind/rndc.conf:g' \
			-e 's:/etc/rndc.key:/etc/bind/rndc.key:g' \
			"${i}" || die "sed failed, ${i} doesn't exist"
	done

	if use dlz; then
		epatch "${FILESDIR}"/${PN}-9.4.0-dlzbdb-close_cursor.patch

		# bind fails to reconnect to MySQL5 databases, bug #180720, patch by Nicolas Brousse
		# (http://www.shell-tips.com/2007/09/04/bind-950-patch-dlz-mysql-5-for-auto-reconnect/)
		if use mysql && has_version ">=dev-db/mysql-5"; then
			epatch "${FILESDIR}"/bind-dlzmysql5-reconnect.patch
		fi

		if use ldap; then
			# bug 238681
			epatch "${FILESDIR}/bind-9.6.1-dlz-patch-ldap-url.patch" \
				"${FILESDIR}/bind-9.6.1-dlz-patch-dollar2.patch"
		fi
	fi

	# should be installed by bind-tools
	sed -i -r -e "s:(nsupdate|dig) ::g" bin/Makefile.in || die

	# sdb-ldap patch as per  bug #160567
	# Upstream URL: http://bind9-ldap.bayour.com/
	# FIXME: bug 302735
#	use sdb-ldap && epatch "${WORKDIR}"/sdb-ldap/${PN}-sdb-ldap-${SDB_LDAP_VER}.patch

	if use geoip; then
		cp "${DISTDIR}"/${GEOIP_P}.patch "${S}" || die
		sed -i -e 's/-RELEASEVER=3/-RELEASEVER=2/' \
			-e 's/+RELEASEVER=3-geoip-1.3/+RELEASEVER=2-geoip-1.3/' \
			${GEOIP_P}.patch || die
		epatch ${GEOIP_P}.patch
	fi

	# bug #220361
	rm {aclocal,libtool}.m4
	WANT_AUTOCONF=2.5 AT_NO_RECURSIVE=1 eautoreconf

	# remove useless c++ checks
	epunt_cxx
}

src_configure() {
	local myconf=""

	use dlz && {
		myconf="${myconf} --with-dlz-filesystem --with-dlz-stub"
		use postgres && myconf="${myconf} --with-dlz-postgres"
		use mysql && myconf="${myconf} --with-dlz-mysql"
		use berkdb && myconf="${myconf} --with-dlz-bdb"
		use ldap && myconf="${myconf} --with-dlz-ldap"
		use odbc && myconf="${myconf} --with-dlz-odbc"
	}

	if use threads; then
		if use dlz && use mysql; then
			ewarn
			ewarn "MySQL uses thread local storage in its C api. Thus MySQL"
			ewarn "requires that each thread of an application execute a MySQL"
			ewarn "\"thread initialization\" to setup the thread local storage."
			ewarn "This is impossible to do safely while staying within the DLZ"
			ewarn "driver API. This is a limitation caused by MySQL, and not"
			ewarn "the DLZ API."
			ewarn "Because of this BIND MUST only run with a single thread when"
			ewarn "using the MySQL driver."
			ewarn
			myconf="${myconf} --disable-linux-caps --disable-threads"
			ewarn "Threading support disabled"
		else
			myconf="${myconf} --enable-linux-caps --enable-threads"
			einfo "Threading support enabled"
		fi
	else
		myconf="${myconf} --disable-linux-caps --disable-threads"
	fi

	if use urandom; then
		myconf="${myconf} --with-randomdev=/dev/urandom"
	else
		myconf="${myconf} --with-randomdev=/dev/random"
	fi

	use geoip && myconf="${myconf} --with-geoip"

	# bug #158664
	gcc-specs-ssp && replace-flags -O[23s] -O

	export BUILD_CC=$(tc-getBUILD_CC)
	econf \
		--sysconfdir=/etc/bind \
		--localstatedir=/var \
		--with-libtool \
		$(use_with ssl openssl) \
		$(use_with idn) \
		$(use_enable ipv6) \
		$(use_with xml libxml2) \
		$(use_with gssapi) \
		${myconf}

	# bug #151839
	echo '#undef SO_BSDCOMPAT' >> config.h
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc CHANGES FAQ KNOWN-DEFECTS README

	if use idn; then
		dodoc README.idnkit || die
	fi

	if use doc; then
		dodoc doc/arm/Bv9ARM.pdf || die

		docinto misc
		dodoc doc/misc/* || die

		# might a 'html' useflag make sense?
		docinto html
		dohtml -r doc/arm/* || die

		docinto	draft
		dodoc doc/draft/* || die

		docinto rfc
		dodoc doc/rfc/* || die

		docinto contrib
		dodoc contrib/named-bootconf/named-bootconf.sh \
			contrib/nanny/nanny.pl || die

		# some handy-dandy dynamic dns examples
		cd "${D}"/usr/share/doc/${PF}
		tar xf "${DISTDIR}"/dyndns-samples.tbz2 || die
	fi

	use geoip && dodoc "${DISTDIR}"/${GEOIP_P}-readme.txt

	insinto /etc/bind
	newins "${FILESDIR}"/named.conf-r4 named.conf || die

	# ftp://ftp.rs.internic.net/domain/named.cache:
	insinto /var/bind
	doins "${FILESDIR}"/named.cache || die

	insinto /var/bind/pri
	newins "${FILESDIR}"/127.zone-r1 127.zone || die
	newins "${FILESDIR}"/localhost.zone-r3 localhost.zone || die

	newinitd "${FILESDIR}"/named.init-r8 named || die
	newconfd "${FILESDIR}"/named.confd-r4 named || die

	newenvd "${FILESDIR}"/10bind.env 10bind || die

	# Let's get rid of those tools and their manpages since they're provided by bind-tools
	rm -f "${D}"/usr/share/man/man1/{dig,host,nslookup}.1*
	rm -f "${D}"/usr/share/man/man8/{dnssec-keygen,nsupdate}.8*
	rm -f "${D}"/usr/bin/{dig,host,nslookup,dnssec-keygen,nsupdate}
	rm -f "${D}"/usr/sbin/{dig,host,nslookup,dnssec-keygen,nsupdate}

	dosym /var/bind/named.cache /var/bind/root.cache || die
	dosym /var/bind/pri /etc/bind/pri || die
	dosym /var/bind/sec /etc/bind/sec || die
	keepdir /var/bind/sec

	dodir /var/{run,log}/named || die

	fowners root:named /{etc,var}/bind /var/{run,log}/named /var/bind/{sec,pri}
	fowners root:named /var/bind/named.cache /var/bind/pri/{127,localhost}.zone /etc/bind/named.conf
	fperms 0640 /var/bind/named.cache /var/bind/pri/{127,localhost}.zone /etc/bind/named.conf
	fperms 0750 /etc/bind /var/bind/pri
	fperms 0770 /var/{run,log}/named /var/bind/{,sec}
}

pkg_postinst() {
	if [ ! -f '/etc/bind/rndc.key' ]; then
		if use urandom; then
			einfo "Using /dev/urandom for generating rndc.key"
			/usr/sbin/rndc-confgen -r /dev/urandom -a
			echo
		else
			einfo "Using /dev/random for generating rndc.key"
			/usr/sbin/rndc-confgen -a
			echo
		fi
		chown root:named /etc/bind/rndc.key
		chmod 0640 /etc/bind/rndc.key
	fi

	einfo
	einfo "You can edit /etc/conf.d/named to customize named settings"
	einfo
	use mysql || use postgres || use ldap && {
		elog "If your named depends on MySQL/PostgreSQL or LDAP,"
		elog "uncomment the specified rc_named_* lines in your"
		elog "/etc/conf.d/named config to ensure they'll start before bind"
		einfo
	}
	einfo "If you'd like to run bind in a chroot AND this is a new"
	einfo "install OR your bind doesn't already run in a chroot:"
	einfo "1) Uncomment and set the CHROOT variable in /etc/conf.d/named."
	einfo "2) Run \`emerge --config '=${CATEGORY}/${PF}'\`"
	einfo

	CHROOT=$(source /etc/conf.d/named 2>/dev/null; echo ${CHROOT})
	if [[ -n ${CHROOT} ]]; then
		elog "NOTE: As of net-dns/bind-9.4.3_p5-r1 the chroot part of the init-script got some major changes!"
		elog "To enable the old behaviour (without using mount) uncomment the"
		elog "CHROOT_NOMOUNT option in your /etc/conf.d/named config."
		elog "If you decide to use the new/default method, ensure to make backup"
		elog "first and merge your existing configs/zones to /etc/bind and"
		elog "/var/bind because bind will now mount the needed directories into"
		elog "the chroot dir."
	fi

	ewarn
	ewarn "NOTE: /var/bind/named.ca has been renamed to /var/bind/named.cache"
	ewarn "you may need to fix your named.conf!"
	ewarn
	ewarn "NOTE: If you upgrade from <net-dns/bind-9.4.3_p5-r1, you may encounter permission problems"
	ewarn "To fix the permissions do:"
	ewarn "chown root:named /{etc,var}/bind /var/{run,log}/named /var/bind/{sec,pri}"
	ewarn "chown root:named /var/bind/named.cache /var/bind/pri/{127,localhost}.zone /etc/bind/{bind.keys,named.conf}"
	ewarn "chmod 0640 /var/bind/named.cache /var/bind/pri/{127,localhost}.zone /etc/bind/{bind.keys,named.conf}"
	ewarn "chmod 0750 /etc/bind /var/bind/pri"
	ewarn "chmod 0770 /var/{run,log}/named /var/bind/{,sec}"
	ewarn
}

pkg_config() {
	CHROOT=$(source /etc/conf.d/named; echo ${CHROOT})
	CHROOT_NOMOUNT=$(source /etc/conf.d/named; echo ${CHROOT_NOMOUNT})

	if [[ -z "${CHROOT}" ]]; then
		eerror "This config script is designed to automate setting up"
		eerror "a chrooted bind/named. To do so, please first uncomment"
		eerror "and set the CHROOT variable in '/etc/conf.d/named'."
		die "Unset CHROOT"
	fi
	if [[ -d "${CHROOT}" ]]; then
		ewarn "NOTE: As of net-dns/bind-9.4.3_p5-r1 the chroot part of the init-script got some major changes!"
		ewarn "To enable the old behaviour (without using mount) uncomment the"
		ewarn "CHROOT_NOMOUNT option in your /etc/conf.d/named config."
		ewarn
		ewarn "${CHROOT} already exists... some things might become overridden"
		ewarn "press CTRL+C if you don't want to continue"
		sleep 10
	fi

	echo; einfo "Setting up the chroot directory..."

	mkdir -m 0750 -p ${CHROOT}
	mkdir -m 0755 -p ${CHROOT}/{dev,etc,var/{run,log}}
	mkdir -m 0750 -p ${CHROOT}/etc/bind
	mkdir -m 0770 -p ${CHROOT}/var/{bind,{run,log}/named}
	chown root:named ${CHROOT} ${CHROOT}/var/{bind,{run,log}/named} ${CHROOT}/etc/bind

	cp /etc/localtime ${CHROOT}/etc/localtime

	mknod ${CHROOT}/dev/null c 1 3
	chmod 0666 ${CHROOT}/dev/null

	mknod ${CHROOT}/dev/zero c 1 5
	chmod 0666 ${CHROOT}/dev/zero

	if use urandom; then
		mknod ${CHROOT}/dev/urandom c 1 9
		chmod 0666 ${CHROOT}/dev/urandom
	else
		mknod ${CHROOT}/dev/random c 1 8
		chmod 0666 ${CHROOT}/dev/random
	fi

	if [ "${CHROOT_NOMOUNT:-0}" -ne 0 ]; then
		cp -a /etc/bind ${CHROOT}/etc/
		cp -a /var/bind ${CHROOT}/var/
	fi

	elog "You may need to add the following line to your syslog-ng.conf:"
	elog "source jail { unix-stream(\"${CHROOT}/dev/log\"); };"
}
