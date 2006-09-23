# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.2.10-r7.ebuild,v 1.12 2006/09/23 19:07:05 chtekk Exp $

inherit eutils flag-o-matic toolchain-funcs

KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 sparc x86"

IUSE="authfile hardened ipv6 ldap mysql ncurses noauthunix pam postgres selinux sendfile shaper softquota ssl tcpd xinetd"

SHAPER_VER="0.5.5"

DESCRIPTION="An advanced and very configurable FTP server."
SRC_URI="ftp://ftp.proftpd.org/distrib/source/${P}.tar.bz2
		shaper? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-shaper-${SHAPER_VER}.tar.gz )"
HOMEPAGE="http://www.proftpd.org/
		http://www.castaglia.org/proftpd/"

SLOT="0"
LICENSE="GPL-2"

DEPEND="ldap? ( >=net-nds/openldap-1.2.11 )
		mysql? ( >=dev-db/mysql-3.23.26 )
		ncurses? ( sys-libs/ncurses )
		pam? ( virtual/pam )
		postgres? ( >=dev-db/postgresql-7.3 )
		ssl? ( >=dev-libs/openssl-0.9.6f )
		tcpd? ( >=sys-apps/tcp-wrappers-7.6-r3 )
		xinetd? ( sys-apps/xinetd )"

RDEPEND="${DEPEND}
		net-ftp/ftpbase
		selinux? ( sec-policy/selinux-ftpd )"

pkg_setup() {
	# Add the proftpd user to make the default config
	# work out-of-the-box
	enewgroup proftpd
	enewuser proftpd -1 -1 -1 proftpd
}

src_unpack() {
	unpack ${P}.tar.bz2

	cd "${S}"

	# Fix stripping of files
	sed -e "s| @INSTALL_STRIP@||g" -i Make*

	if use shaper ; then
		unpack ${PN}-mod-shaper-${SHAPER_VER}.tar.gz
		cp -f mod_shaper/mod_shaper.c contrib/
	fi

	# Fix ftpshut and SqlShowInfo, bug #100364
	epatch "${FILESDIR}/${P}-ftpshut.patch"
	epatch "${FILESDIR}/${P}-sqlshowinfo.patch"

	# Fix gcc4 compile errors, bug #145940
	epatch "${FILESDIR}/${P}-gcc4_mod_quotatab_sql.patch"

	# Fix OpenSSL 0.9.8 compile errors, bug #146534
	epatch "${FILESDIR}/${P}-openssl_0.9.8.patch"
}

src_compile() {
	addpredict /etc/krb5.conf
	local modules myconf

	modules="mod_ratio:mod_readme"
	use pam && modules="${modules}:mod_auth_pam"
	use shaper && modules="${modules}:mod_shaper"
	use ssl && modules="${modules}:mod_tls"
	use tcpd && modules="${modules}:mod_wrap"

	if use ldap ; then
		modules="${modules}:mod_ldap"
		append-ldflags "-lresolv"
	fi

	if use mysql && use postgres ; then
		ewarn "ProFTPD only supports either the MySQL or PostgreSQL modules."
		ewarn "Presently this ebuild defaults to mysql. If you would like to"
		ewarn "change the default behaviour, merge ProFTPD with:"
		ewarn "USE='-mysql postgres' emerge proftpd"
		epause 5
	fi

	if use mysql ; then
		modules="${modules}:mod_sql:mod_sql_mysql"
		myconf="${myconf} --with-includes=/usr/include/mysql"
	elif use postgres ; then
		modules="${modules}:mod_sql:mod_sql_postgres"
		myconf="${myconf} --with-includes=/usr/include/postgresql"
	fi

	if use softquota ; then
		modules="${modules}:mod_quotatab"
		if use mysql || use postgres ; then
			modules="${modules}:mod_quotatab_sql"
		fi
		if use ldap ; then
			modules="${modules}:mod_quotatab_file:mod_quotatab_ldap"
		else
			modules="${modules}:mod_quotatab_file"
		fi
	fi

	# bug #30359
	use hardened && echo > lib/libcap/cap_sys.c
	gcc-specs-pie && echo > lib/libcap/cap_sys.c

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
		$(use_enable ipv6) \
		$(use_enable ncurses) \
		$(use_with sendfile) \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	# Note rundir needs to be specified to avoid sandbox violation
	# on initial install. See Make.rules
	emake DESTDIR="${D}" install || die "emake install failed"

	keepdir /var/run/proftpd

	dodoc contrib/UPGRADE.mod_sql "${FILESDIR}/proftpd.conf" \
		COPYING CREDITS ChangeLog NEWS README* \
		doc/{license.txt,GetConf}
	dohtml doc/*.html

	use shaper && dohtml mod_shaper/mod_shaper.html

	docinto rfc
	dodoc doc/rfc/*.txt

	mv -f "${D}/etc/proftpd/proftpd.conf" "${D}/etc/proftpd/proftpd.conf.distrib"

	insinto /etc/proftpd
	newins "${FILESDIR}/proftpd.conf" proftpd.conf.sample

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/proftpd.xinetd" proftpd
	fi

	newinitd "${FILESDIR}/proftpd.rc6" proftpd
}

pkg_postinst() {
	einfo
	einfo "You can find the config files in /etc/proftpd"
	einfo
	einfo "mod_delay has been causing more bad than good and has been removed."
	einfo
	ewarn "With the introduction of net-ftp/ftpbase the ftp user is now ftp."
	ewarn "Remember to change that in the configuration file."
	einfo
}
