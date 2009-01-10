# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/bind/bind-9.4.3_p1.ebuild,v 1.7 2009/01/10 16:42:51 armin76 Exp $

inherit eutils libtool autotools toolchain-funcs flag-o-matic

DLZ_VERSION="9.3.3"
MY_PV="${PV/_p1/-P1}"

DESCRIPTION="BIND - Berkeley Internet Name Domain - Name Server"
HOMEPAGE="http://www.isc.org/products/BIND/bind9.html"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${MY_PV}/${PN}-${MY_PV}.tar.gz
	doc? ( mirror://gentoo/dyndns-samples.tbz2 )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86"
IUSE="ssl ipv6 doc dlz postgres berkdb mysql odbc ldap selinux idn threads resolvconf urandom"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6g )
	mysql? ( >=virtual/mysql-4.0 )
	odbc? ( >=dev-db/unixODBC-2.2.6 )
	ldap? ( net-nds/openldap )
	idn? ( net-dns/idnkit )"

RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-bind )
	resolvconf? ( net-dns/openresolv )"

S="${WORKDIR}/${PN}-${MY_PV}"

pkg_setup() {
	use threads && {
		echo
		ewarn "If you're in vserver enviroment, you're probably want to"
		ewarn "disable threads support because of linux capabilities dependency"
		echo
	}

	ebegin "Creating named group and user"
	enewgroup named 40
	enewuser named 40 -1 /etc/bind named
	eend ${?}
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Adjusting PATHs in manpages
	for i in bin/{named/named.8,check/named-checkconf.8,rndc/rndc.8} ; do
		sed -i \
			-e 's:/etc/named.conf:/etc/bind/named.conf:g' \
			-e 's:/etc/rndc.conf:/etc/bind/rndc.conf:g' \
			-e 's:/etc/rndc.key:/etc/bind/rndc.key:g' \
			"${i}"
	done

	use dlz && epatch "${FILESDIR}"/${PN}-9.4.0-dlzbdb-close_cursor.patch

	# bind fails to reconnect to MySQL5 databases, bug #180720, patch by Nicolas Brousse
	# (http://www.shell-tips.com/2007/09/04/bind-950-patch-dlz-mysql-5-for-auto-reconnect/)
	use dlz && use mysql && epatch "${FILESDIR}"/bind-dlzmysql5-reconnect.patch

	# should be installed by bind-tools
	sed -e "s:nsupdate ::g" -i "${S}"/bin/Makefile.in

	# bug #220361
	rm "${S}"/aclocal.m4 "${S}"/libtool.m4
	WANT_AUTOCONF=2.5 AT_NO_RECURSIVE=1 eautoreconf

	# bug #151839
	sed -e \
		's:struct isc_socket {:#undef SO_BSDCOMPAT\n\nstruct isc_socket {:' \
		-i lib/isc/unix/socket.c

	# remove useless c++ checks
	epunt_cxx
}

src_compile() {
	local myconf=""

	use ssl && myconf="${myconf} --with-openssl"
	use idn && myconf="${myconf} --with-idn"

	use dlz && {
		myconf="${myconf} --with-dlz-filesystem --with-dlz-stub"
		use postgres && myconf="${myconf} --with-dlz-postgres"
		use mysql && myconf="${myconf} --with-dlz-mysql"
		use berkdb && myconf="${myconf} --with-dlz-bdb"
		use ldap  && myconf="${myconf} --with-dlz-ldap"
		use odbc  && myconf="${myconf} --with-dlz-odbc"
	}

	if use threads; then
		if use dlz && use mysql; then
			echo
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
			epause 10
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

	# bug #158664
	gcc-specs-ssp && replace-flags -O[23s] -O
	export BUILD_CC="${CBUILD}-gcc"
	econf \
		--sysconfdir=/etc/bind \
		--localstatedir=/var \
		--with-libtool \
		`use_enable ipv6` \
		${myconf} || die "econf failed"

	emake -j1 || die "failed to compile bind"
}

src_install() {
	einstall || die "failed to install bind"

	dodoc CHANGES COPYRIGHT FAQ README

	use doc && {
		docinto misc
		dodoc doc/misc/*

		docinto html
		dohtml doc/arm/*

		docinto	draft
		dodoc doc/draft/*

		docinto rfc
		dodoc doc/rfc/*

		docinto contrib
		dodoc contrib/named-bootconf/named-bootconf.sh \
			contrib/nanny/nanny.pl

		# some handy-dandy dynamic dns examples
		cd "${D}"/usr/share/doc/${PF}
		tar pjxf ${DISTFILES}/dyndns-samples.tbz2
	}

	newenvd "${FILESDIR}"/10bind.env 10bind

	dodir /etc/bind /var/bind/{pri,sec}
	keepdir /var/bind/sec

	insinto /etc/bind ; newins "${FILESDIR}"/named.conf-r3 named.conf

	# ftp://ftp.rs.internic.net/domain/named.ca:
	insinto /var/bind ; doins "${FILESDIR}"/named.ca

	insinto /var/bind/pri
	newins "${FILESDIR}"/127.zone-r1 127.zone
	newins "${FILESDIR}"/localhost.zone-r3 localhost.zone

	newinitd "${FILESDIR}"/named.init-r5 named
	newconfd "${FILESDIR}"/named.confd-r2 named

	dosym ../../var/bind/named.ca /var/bind/root.cache
	dosym ../../var/bind/pri /etc/bind/pri
	dosym ../../var/bind/sec /etc/bind/sec

	# Let's get rid of those tools and their manpages since they're provided by bind-tools
	rm -f "${D}"/usr/share/man/man1/{dig.1,host.1,nslookup.1,nsupdate.1}
	rm -f "${D}"/usr/share/man/man8/dnssec-keygen.8
	rm -f "${D}"/usr/bin/{dig,host,nslookup,dnssec-keygen,nsupdate}
}

pkg_postinst() {
	if [ ! -f '/etc/bind/rndc.key' ]; then
		if [ -c /dev/urandom ]; then
			einfo "Using /dev/urandom for generating rndc.key"
			/usr/sbin/rndc-confgen -r /dev/urandom -a -u named
			echo
		else
			einfo "Using /dev/random for generating rndc.key"
			/usr/sbin/rndc-confgen -a -u named
			echo
		fi
	fi

	install -d -o named -g named "${ROOT}"/var/run/named \
		"${ROOT}"/var/bind/pri "${ROOT}"/var/bind/sec
	chown -R named:named "${ROOT}"/var/bind

	elog "The default zone files are now installed as *.zone,"
	elog "be careful merging config files if you have modified"
	elog "/var/bind/pri/127 or /var/bind/pri/localhost"
	elog
	elog "You can edit /etc/conf.d/named to customize named settings"
	elog
	elog "The BIND ebuild now includes chroot support."
	elog "If you like to run bind in chroot AND this is a new install OR"
	elog "your bind doesn't already run in chroot, simply run:"
	elog "\`emerge --config '=${CATEGORY}/${PF}'\`"
	elog "Before running the above command you might want to change the chroot"
	elog "dir in /etc/conf.d/named. Otherwise /chroot/dns will be used."
	elog
	elog "Recently verisign added a wildcard A record to the .COM and .NET TLD"
	elog "zones making all .com and .net domains appear to be registered"
	elog "This causes many problems such as breaking important anti-spam checks"
	elog "which verify source domains exist. ISC released a patch for BIND which"
	elog "adds 'delegation-only' zones to allow admins to return the .com and .net"
	elog "domain resolution to their normal function."
	elog
	elog "There is no need to create a com or net data file. Just the"
	elog "entries to the named.conf file is enough."
	elog
	elog "	zone "com" IN { type delegation-only; };"
	elog "	zone "net" IN { type delegation-only; };"

	echo
	ewarn "BIND >=9.2.5 makes the priority argument to MX records mandatory"
	ewarn "when it was previously optional.  If the priority is missing, BIND"
	ewarn "won't load the zone file at all."
	echo
}

pkg_config() {
	CHROOT=`sed -n 's/^[[:blank:]]\?CHROOT="\([^"]\+\)"/\1/p' /etc/conf.d/named 2>/dev/null`
	EXISTS="no"

	if [ -z "${CHROOT}" -a ! -d "/chroot/dns" ]; then
		CHROOT="/chroot/dns"
	elif [ -d ${CHROOT} ]; then
		eerror; eerror "${CHROOT:-/chroot/dns} already exists. Quitting."; eerror; EXISTS="yes"
	fi

	if [ ! "$EXISTS" = yes ]; then
		einfo ; einfon "Setting up the chroot directory..."
		mkdir -m 700 -p ${CHROOT}
		mkdir -p ${CHROOT}/{dev,etc,var/run/named}
		chown -R named:named ${CHROOT}/var/run/named
		cp -R /etc/bind ${CHROOT}/etc/
		cp /etc/localtime ${CHROOT}/etc/localtime
		chown named:named ${CHROOT}/etc/bind/rndc.key
		cp -R /var/bind ${CHROOT}/var/
		chown -R named:named ${CHROOT}/var/
		mknod ${CHROOT}/dev/zero c 1 5
		chmod 666 ${CHROOT}/dev/zero
		if use urandom; then
			mknod ${CHROOT}/dev/urandom c 1 9
			chmod 666 ${CHROOT}/dev/urandom
		else
			mknod ${CHROOT}/dev/random c 1 8
			chmod 666 ${CHROOT}/dev/random
		fi
		echo "none    ${CHROOT}/proc    proc    defaults    0 0" >>/etc/fstab
		mkdir ${CHROOT}/proc
		mount -t proc none ${CHROOT}/proc
		if [ -f '/etc/syslog-ng/syslog-ng.conf' ]; then
			echo "source jail { unix-stream(\"${CHROOT}/dev/log\"); };" >>/etc/syslog-ng/syslog-ng.conf
		fi
		chown root:named ${CHROOT}
		chmod 0750 ${CHROOT}

		grep -q "^#[[:blank:]]\?CHROOT" /etc/conf.d/named ; RETVAL=$?
		if [ $RETVAL = 0 ]; then
			sed 's/^# \?\(CHROOT.*\)$/\1/' /etc/conf.d/named > /etc/conf.d/named.orig 2>/dev/null
			mv --force /etc/conf.d/named.orig /etc/conf.d/named
		fi

		sleep 1; echo " Done."; sleep 1
		einfo
		einfo "Add the following to your root .bashrc or .bash_profile: "
		einfo "   alias rndc='rndc -k ${CHROOT}/etc/bind/rndc.key'"
		einfo "Then do the following: "
		einfo "   source /root/.bashrc or .bash_profile"
		einfo
	fi
}
