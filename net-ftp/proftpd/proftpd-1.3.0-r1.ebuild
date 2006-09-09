# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.3.0-r1.ebuild,v 1.7 2006/09/09 19:53:45 wormo Exp $

inherit eutils flag-o-matic toolchain-funcs

IUSE="acl authfile clamav hardened ifsession ipv6 ldap mysql ncurses noauthunix opensslcrypt pam postgres
	radius rewrite selinux shaper sitemisc softquota ssl tcpd vroot xinetd"

SHAPER_VER="0.5.6"
VROOT_VER="0.7.1"

S=${WORKDIR}/${P}

DESCRIPTION="An advanced and very configurable FTP server"
SRC_URI="ftp://ftp.proftpd.org/distrib/source/${P}.tar.bz2
		shaper? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-shaper-${SHAPER_VER}.tar.gz )
		clamav? ( http://www.uglyboxindustries.com/mod_clamav.c http://www.uglyboxindustries.com/mod_clamav.html )
		vroot?	 ( http://www.castaglia.org/${PN}/modules/${PN}-mod-vroot-${VROOT_VER}.tar.gz )"
HOMEPAGE="http://www.proftpd.org/
		http://www.castaglia.org/proftpd/
		http://www.uglyboxindustries.com/open-source.php"

SLOT="0"
LICENSE="GPL-2"
#removed mips due to dep issue with clamav
KEYWORDS="alpha amd64 ~hppa ppc ppc64 ~sparc x86"

DEPEND="acl? ( sys-apps/acl sys-apps/attr )
	clamav? ( app-antivirus/clamav )
	ldap? ( >=net-nds/openldap-1.2.11 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ncurses? ( sys-libs/ncurses )
	opensslcrypt? ( >=dev-libs/openssl-0.9.6f )
	pam? ( virtual/pam )
	postgres? ( >=dev-db/postgresql-7.3 )
	ssl? ( >=dev-libs/openssl-0.9.6f )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r3 )
	xinetd? ( sys-apps/xinetd )"

RDEPEND="${DEPEND}
	net-ftp/ftpbase
	selinux? ( sec-policy/selinux-ftpd )"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch "${FILESDIR}"/mod_sql_mysql.diff
	if use shaper; then
		unpack ${PN}-mod-shaper-${SHAPER_VER}.tar.gz
		cp mod_shaper/mod_shaper.c contrib/
	fi
	if use clamav; then
		cp "${DISTDIR}"/mod_clamav.c contrib/
		cp "${DISTDIR}"/mod_clamav.html doc/
	fi
	if use vroot; then
		unpack ${PN}-mod-vroot-${VROOT_VER}.tar.gz
		cp mod_vroot/mod_vroot.c contrib/
		cp mod_vroot/mod_vroot.html doc/
	fi
}

src_compile() {
	addpredict /etc/krb5.conf
	local modules myconf

	modules="mod_ratio:mod_readme"
	use acl && modules="${modules}:mod_facl"
	use clamav && modules="${modules}:mod_clamav"
	use pam && modules="${modules}:mod_auth_pam"
	use radius && modules="${modules}:mod_radius"
	use rewrite && modules="${modules}:mod_rewrite"
	use shaper && modules="${modules}:mod_shaper"
	use sitemisc && modules="${modules}:mod_site_misc"
	use ssl && modules="${modules}:mod_tls"
	use tcpd && modules="${modules}:mod_wrap"
	use vroot && modules="${modules}:mod_vroot"

	if use ldap; then
		modules="${modules}:mod_ldap"
		append-ldflags "-lresolv"
	fi

	if use opensslcrypt; then
		append-ldflags "-lcrypto"
		myconf="${myconf} --with-includes=/usr/include/openssl"
		CFLAGS="${CFLAGS} -DHAVE_OPENSSL"
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

	# mod_ifsession should be the last module in the --with-modules list
	# see http://www.castaglia.org/proftpd/modules/mod_ifsession.html#Installation
	use ifsession && modules="${modules}:mod_ifsession"

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
		$(use_enable ncurses) \
		$(use_enable ipv6) \
		$(use_enable acl facl ) \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	# Note rundir needs to be specified to avoid sandbox violation
	# on initial install. See Make.rules
	make DESTDIR=${D} install || die

	keepdir /var/run/proftpd

	dodoc ${FILESDIR}/proftpd.conf \
		COPYING CREDITS ChangeLog NEWS README* \
		doc/license.txt
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

	newinitd ${FILESDIR}/proftpd.rc6-r2 proftpd
}

pkg_postinst() {
	einfo
	einfo 'You can find the config files in /etc/proftpd'
	einfo
	ewarn 'With introduction of net-ftp/ftpbase the ftp user is now ftp.'
	ewarn 'Remember to change that in the configuration file.'
}
