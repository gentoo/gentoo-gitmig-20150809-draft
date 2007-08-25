# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/bind/bind-9.2.6-r4.ebuild,v 1.15 2007/08/25 14:32:26 vapier Exp $

inherit eutils libtool autotools

DLZ_VERSION="9.2.5"
MY_P="${P}-P1"
MY_PV="${PV}-P1"

DESCRIPTION="BIND - Berkeley Internet Name Domain - Name Server"
HOMEPAGE="http://www.isc.org/products/BIND/bind9.html"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${MY_PV}/${MY_P}.tar.gz
	mirror://gentoo/dyndns-samples.tbz2
	dlz? ( http://dev.gentoo.org/~voxus/dlz/dlz-${DLZ_VERSION}.patch.bz2 )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ~ppc ppc64 s390 sh sparc x86"
IUSE="ssl ipv6 doc dlz postgres berkdb bind-mysql mysql odbc ldap selinux idn threads"

DEPEND="!net-dns/idnkit
	ssl? ( >=dev-libs/openssl-0.9.6g )
	mysql? ( >=virtual/mysql-4.0 )
	bind-mysql? ( >=virtual/mysql-4.0 )
	odbc? ( >=dev-db/unixODBC-2.2.6 )
	ldap? ( net-nds/openldap )"
RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-bind )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	ebegin "Creating named group and user"
	enewgroup named 40
	enewuser named 40 -1 /etc/bind named
	eend ${?}
}

src_unpack() {
	use threads && {
		echo
		ewarn "If you're in vserver enviroment, you're probably want to"
		ewarn "disable threads support because of linux capabilities dependency"
		echo
	}

	unpack ${A} && cd ${S}

	# Adjusting PATHs in manpages
	for i in `echo bin/{named/named.8,check/named-checkconf.8,rndc/rndc.8}`; do
		sed -i -e 's:/etc/named.conf:/etc/bind/named.conf:g' \
		       -e 's:/etc/rndc.conf:/etc/bind/rndc.conf:g' \
		       -e 's:/etc/rndc.key:/etc/bind/rndc.key:g' \
		       ${i}
	done

	if use dlz; then
		epatch ${DISTDIR}/dlz-${DLZ_VERSION}.patch.bz2
		epatch ${FILESDIR}/bind-${DLZ_VERSION}-berkdb_fix.patch
		epatch ${FILESDIR}/${PN}-dlzbdb-includes.patch
	fi

	if use bind-mysql; then
		if use dlz; then
			MP=${P}-dlz-mysql.patch
		else
			MP=${P}-mysql.patch
		fi

		ebegin "Fixing mysql patch"
		eindent

		cp ${FILESDIR}/${MP} ${T}/${MP}

		sed -e "s:-I/usr/local/include:`mysql_config --include`:" \
			-e "s:-L/usr/local/lib/mysql -lmysqlclient:`mysql_config --libs`:" \
			-i ${T}/${MP}

		epatch ${T}/${MP}

		eoutdent
		eend $?
	fi

	if use idn; then
		epatch ${S}/contrib/idn/idnkit-1.0-src/patch/bind9/${P}-patch
	fi

	# it should be installed by bind-tools
	sed -e "s:nsupdate ::g" -i ${S}/bin/Makefile.in

	cd ${S}
	WANT_AUTOCONF=2.5 AT_NO_RECURSIVE=1 eautoreconf || die "eautoreconf failed"
}

src_compile() {
	local myconf=""

	use ssl && myconf="${myconf} --with-openssl"
	use dlz && {
		myconf="${myconf} --with-dlz-filesystem --with-dlz-stub"
		use postgres && myconf="${myconf} --with-dlz-postgres"
		use mysql && myconf="${myconf} --with-dlz-mysql"
		use berkdb && myconf="${myconf} --with-dlz-bdb"
		use ldap  && myconf="${myconf} --with-dlz-ldap"
		use odbc  && myconf="${myconf} --with-dlz-odbc=/usr/include"
	}

	if use threads; then
		if use dlz && use mysql; then
			echo
			ewarn
			ewarn "MySQL uses thread local storage in its C api. Thus MySQL"
			ewarn "requires that each thread of an application execute a MySQL"
			ewarn "\"thread initialization\" to setup the thread local storage."
			ewarn "This is impossible to do safely while staying within the DLZ"
			ewarn "driver API. This is a limitation caused by MySQL, and not the"
			ewarn "DLZ API."
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

	econf \
		--sysconfdir=/etc/bind \
		--localstatedir=/var \
		`use_enable ipv6` \
		--with-libtool \
		${myconf} || die "econf failed"

	emake -j1 || die "failed to compile bind"

	if use idn; then
		cd ${S}/contrib/idn/idnkit-1.0-src
		econf || die "idn econf failed"
		emake || die "idn emake failed"
	fi
}

src_install() {
	einstall || die "failed to install bind"

	dodoc CHANGES COPYRIGHT FAQ README

	use doc && {
		docinto misc ; dodoc doc/misc/*
		docinto html ; dohtml doc/arm/*
		docinto	draft ; dodoc doc/draft/*
		docinto rfc ; dodoc doc/rfc/*
		docinto contrib ; dodoc contrib/named-bootconf/named-bootconf.sh \
		contrib/nanny/nanny.pl
	}

	newenvd ${FILESDIR}/10bind.env 10bind

	# some handy-dandy dynamic dns examples
	cd ${D}/usr/share/doc/${PF}
	tar pjxf ${DISTDIR}/dyndns-samples.tbz2

	dodir /etc/bind /var/bind/{pri,sec}
	keepdir /var/bind/sec

	insinto /etc/bind ; newins ${FILESDIR}/named.conf-r3 named.conf
	# ftp://ftp.rs.internic.net/domain/named.ca:
	insinto /var/bind ; doins ${FILESDIR}/named.ca
	insinto /var/bind/pri ; doins ${FILESDIR}/{127,localhost}.zone

	newinitd ${FILESDIR}/named.init-r3 named
	newconfd ${FILESDIR}/named.confd-r1 named

	dosym ../../var/bind/named.ca /var/bind/root.cache
	dosym ../../var/bind/pri /etc/bind/pri
	dosym ../../var/bind/sec /etc/bind/sec

	if use idn; then
		cd ${S}/contrib/idn/idnkit-1.0-src
		einstall || die "failed to install idn kit"
		docinto idn
		dodoc ChangeLog INSTALL{,.ja} README{,.ja} NEWS
	fi

	# Let's get rid of those tools and their manpages since they're provided by bind-tools
	rm -f ${D}/usr/share/man/man1/{dig.1,host.1,nslookup.1}
	rm -f ${D}/usr/bin/{dig,host,nslookup}
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

	install -d -o named -g named ${ROOT}/var/run/named \
		${ROOT}/var/bind/pri ${ROOT}/var/bind/sec
	chown -R named:named ${ROOT}/var/bind

	elog "The default zone files are now installed as *.zone,"
	elog "be careful merging config files if you have modified"
	elog "/var/bind/pri/127 or /var/bind/pri/localhost"
	elog
	elog "You can edit /etc/conf.d/named to customize named settings"
	elog
	elog "The BIND ebuild now includes chroot support."
	elog "If you like to run bind in chroot AND this is a new install OR"
	elog "your bind doesn't already run in chroot, simply run:"
	elog "\`emerge --config =${CATEGORY}/${PF}\`"
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
		mknod ${CHROOT}/dev/random c 1 8
		chmod 666 ${CHROOT}/dev/{random,zero}
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
