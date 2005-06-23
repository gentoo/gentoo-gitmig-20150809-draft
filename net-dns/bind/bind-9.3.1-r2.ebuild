# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/bind/bind-9.3.1-r2.ebuild,v 1.1 2005/06/23 17:37:44 voxus Exp $

inherit eutils libtool

DESCRIPTION="BIND - Berkeley Internet Name Domain - Name Server"
HOMEPAGE="http://www.isc.org/products/BIND/bind9.html"

SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/${P}.tar.gz
	dlz? ( http://projects.navynet.it/DLZ/ctrix_dlz_9.3.1-1.patch.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="ssl ipv6 doc dlz postgres berkdb mysql odbc ldap selinux idn threads"

DEPEND="sys-apps/groff
	sys-devel/autoconf
	ssl? ( >=dev-libs/openssl-0.9.6g )
	mysql? ( >=dev-db/mysql-4 )
	odbc? ( >=dev-db/unixODBC-2.2.6 )
	ldap? ( net-nds/openldap )"

RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-bind )"

pkg_setup() {
	if use dlz && use idn;
	then
		echo
		eerror "DLZ currently doesn't supports IDN"
		eerror "You should disable 'idn' or 'dlz' use flag to continue"

		die "dlz doesn't support idn currently"
	fi
}

src_unpack() {
	unpack ${A} && cd ${S}

	# Adjusting PATHs in manpages
	for i in `echo bin/{named/named.8,check/named-checkconf.8,rndc/rndc.8}`; do
		sed -i -e 's:/etc/named.conf:/etc/bind/named.conf:g' \
		       -e 's:/etc/rndc.conf:/etc/bind/rndc.conf:g' \
		       -e 's:/etc/rndc.key:/etc/bind/rndc.key:g' \
		       ${i}
	done

	use dlz && {
		epatch ${DISTDIR}/ctrix_dlz_${PV}-1.patch.gz || \
			die "dlz patch failed"
	}

	use idn && {
		epatch ${S}/contrib/idn/idnkit-1.0-src/patch/bind9/${P}-patch || \
			die "idn patch failed"
	}

	# it should be installed by bind-tools
	sed "s:nsupdate ::g" ${S}/bin/Makefile.in > ${T}/Makefile
	mv ${T}/Makefile ${S}/bin/Makefile.in

	cd ${S}
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
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
		use odbc  && myconf="${myconf} --with-dlz-odbc"
	}

	if use threads; then
		if use dlz && use mysql; then
			echo
			ewarn ""
			einfo "MySQL uses thread local storage in its C api. Thus MySQL"
			einfo "requires that each thread of an application execute a MySQL"
			einfo "\"thread initialization\" to setup the thread local storage."
			einfo "This is impossible to do safely while staying within the DLZ"
			einfo "driver API. This is a limitation caused by MySQL, and not"
			einfo "the DLZ API."
			ewarn "Because of this BIND MUST only run with a single thread when"
			ewarn "using the MySQL driver."
			echo
			myconf="${myconf} --disable-threads"
			einfo "Threading support disabled"
			epause 10
		else
			myconf="${myconf} --enable-linux-caps --enable-threads"
			einfo "Threading support enabled"
		fi
	fi

	econf \
		--sysconfdir=/etc/bind \
		--localstatedir=/var \
		--with-libtool \
		`use_enable ipv6` \
		${myconf} || die "econf failed"

	emake -j1 || die "failed to compile bind"

	use idn && {
		cd ${S}/contrib/idn/idnkit-1.0-src
		econf || die "idn econf failed"
		emake || die "idn emake failed"
	}
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
		cd ${D}/usr/share/doc/${PF}
		tar pjxf ${FILESDIR}/dyndns-samples.tbz2
	}

	insinto /etc/env.d
	newins ${FILESDIR}/10bind.env 10bind

	dodir /etc/bind /var/bind/{pri,sec}
	keepdir /var/bind/sec

	insinto /etc/bind ; newins ${FILESDIR}/named.conf-r2 named.conf
	# ftp://ftp.rs.internic.net/domain/named.ca:
	insinto /var/bind ; doins ${FILESDIR}/named.ca
	insinto /var/bind/pri ; doins ${FILESDIR}/{127,localhost}.zone

	exeinto /etc/init.d ; newexe ${FILESDIR}/named.init named
	insinto /etc/conf.d ; newins ${FILESDIR}/named.confd named

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
		/usr/sbin/rndc-confgen -a -u named
	fi

	install -d -o named -g named ${ROOT}/var/run/named \
		${ROOT}/var/bind/pri ${ROOT}/var/bind/sec
	chown -R named:named ${ROOT}/var/bind

	einfo "The default zone files are now installed as *.zone,"
	einfo "be careful merging config files if you have modified"
	einfo "/var/bind/pri/127 or /var/bind/pri/localhost"
	einfo
	einfo "You can edit /etc/conf.d/named to customize named settings"
	einfo
	einfo "The BIND ebuild now includes chroot support."
	einfo "If you like to run bind in chroot AND this is a new install OR"
	einfo "your bind doesn't already run in chroot, simply run:"
	einfo "\`ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\`"
	einfo "Before running the above command you might want to change the chroot"
	einfo "dir in /etc/conf.d/named. Otherwise /chroot/dns will be used."
	echo
	einfo "Recently verisign added a wildcard A record to the .COM and .NET TLD"
	einfo "zones making all .com and .net domains appear to be registered"
	einfo "This causes many problems such as breaking important anti-spam checks"
	einfo "which verify source domains exist. ISC released a patch for BIND which"
	einfo "adds 'delegation-only' zones to allow admins to return the .com and .net"
	einfo "domain resolution to their normal function."
	echo
	einfo "There is no need to create a com or net data file. Just the"
	einfo "entries to the named.conf file is enough."
	echo
	einfo "	zone "com" IN { type delegation-only; };"
	einfo "	zone "net" IN { type delegation-only; };"

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
		chown named:named ${CHROOT}

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
