# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.2.10-r7.ebuild,v 1.9 2006/09/04 23:50:32 humpback Exp $

inherit flag-o-matic eutils

IUSE="hardened ipv6 ldap mysql pam postgres shaper softquota ssl tcpd
	selinux sendfile noauthunix authfile ncurses xinetd"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An advanced and very configurable FTP server"
SRC_URI="ftp://ftp.proftpd.org/distrib/source/${MY_P}.tar.bz2
		shaper? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-shaper-0.5.5.tar.gz )"
HOMEPAGE="http://www.proftpd.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 sparc x86"

DEPEND="pam? ( || ( virtual/pam sys-libs/pam ) )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.3 )
	ssl? ( >=dev-libs/openssl-0.9.6f )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r3 )
	ncurses? ( sys-libs/ncurses )
	xinetd? ( sys-apps/xinetd )"

RDEPEND="${DEPEND}
		net-ftp/ftpbase
		selinux? ( sec-policy/selinux-ftpd )"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	if use shaper; then
		unpack ${PN}-mod-shaper-0.5.5.tar.gz
		mv mod_shaper/mod_shaper.c contrib/
	fi

	# Fix ftpshut and SqlShowInfo, bug #100364
	epatch "${FILESDIR}/proftpd-ftpshut.patch"
	epatch "${FILESDIR}/proftpd-sqlshowinfo.patch"

	# Fix gcc4 compile error, bug #145940
	epatch "${FILESDIR}/gcc4-mod_quotatab_sql.patch"
}

src_compile() {
	addpredict /etc/krb5.conf
	local modules myconf

	modules="mod_ratio:mod_readme"
	use pam && modules="${modules}:mod_auth_pam"
	use tcpd && modules="${modules}:mod_wrap"
	use shaper && modules="${modules}:mod_shaper"

	if use ldap; then
		einfo ldap
		modules="${modules}:mod_ldap"
		append-ldflags "-lresolv"
	fi

	if use ssl; then
		einfo ssl
		# enable mod_tls
		modules="${modules}:mod_tls"
	fi

	if use mysql && use postgres
	then
		ewarn "ProFTPD only supports either the MySQL or PostgreSQL modules."
		ewarn "Presently this ebuild defaults to mysql. If you would like to"
		ewarn "change the default behaviour, merge ProFTPD with;"
		ewarn "USE=\"-mysql postgres\" emerge proftpd"
		epause 5
	fi

	if use mysql; then
		modules="${modules}:mod_sql:mod_sql_mysql"
		myconf="${myconf} --with-includes=/usr/include/mysql"
	elif use postgres; then
		modules="${modules}:mod_sql:mod_sql_postgres"
		myconf="${myconf} --with-includes=/usr/include/postgresql"
	fi

	if use softquota; then
		modules="${modules}:mod_quotatab"
		if use mysql || use postgres; then
			modules="${modules}:mod_quotatab_sql"
		fi
		if use ldap; then
			modules="${modules}:mod_quotatab_file:mod_quotatab_ldap"
		else
			modules="${modules}:mod_quotatab_file"
		fi
	fi

	# New modules for 1.2.9
	# Not sure how these should be enabled yet as no use variables
	# apply currently.  Uncomment if you want to use them though.
	# -raker 06/16/2003
	#
	# modules="${modules}:mod_ifsession"
	# modules="${modules}:mod_radius"
	# modules="${modules}:mod_rewrite"

	# bug #30359
	use hardened && echo > lib/libcap/cap_sys.c
	has_pic && echo > lib/libcap/cap_sys.c

	if use noauthunix ; then
		myconf="${myconf} --disable-auth-unix"
	else
		myconf="${myconf} --enable-auth-unix"
	fi

	econf \
		--sbindir=/usr/sbin \
		--localstatedir=/var/run \
		--sysconfdir=/etc/proftpd \
		--enable-shadow \
		--enable-autoshadow \
		--enable-ctrls \
		--with-modules=${modules} \
		$(use_enable authfile auth-file) \
		$(use_enable ncurses) \
		$(use_enable ipv6) \
		$(use_with sendfile) \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	# Note rundir needs to be specified to avoid sandbox violation
	# on initial install. See Make.rules
	make DESTDIR=${D} install || die

	keepdir /var/run/proftpd

	dodoc contrib/UPGRADE.mod_sql ${FILESDIR}/proftpd.conf \
		COPYING CREDITS ChangeLog NEWS README* \
		doc/{license.txt,GetConf}
	dohtml doc/*.html

	use shaper && dohtml mod_shaper/mod_shaper.html
	docinto rfc
	dodoc doc/rfc/*.txt

	mv ${D}/etc/proftpd/proftpd.conf ${D}/etc/proftpd/proftpd.conf.distrib

	insinto /etc/proftpd
	newins ${FILESDIR}/proftpd.conf proftpd.conf.sample


	if use xinetd; then
		insinto /etc/xinetd.d
		newins ${FILESDIR}/proftpd.xinetd proftpd
	fi

	newinitd ${FILESDIR}/proftpd.rc6 proftpd
}

pkg_postinst() {
	einfo
	einfo 'You can find the config files in /etc/proftpd'
	einfo
	einfo 'mod_delay has been causing more bad than good and has been removed'
	einfo 'see Changelog for more info'
	ewarn 'With introduction of net-ftp/ftpbase the ftp user is now ftp.'
	ewarn 'Remember to change that in the configuration file.'
}
