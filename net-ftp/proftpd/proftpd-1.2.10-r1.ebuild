# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.2.10-r1.ebuild,v 1.3 2004/11/27 23:20:05 josejx Exp $

inherit flag-o-matic eutils

#Mod shaper is giving problems on some machines
IUSE="hardened ipv6 ldap mysql pam postgres shaper softquota ssl tcpd selinux"
#IUSE="hardened ipv6 ldap mysql pam postgres softquota ssl tcpd selinux"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An advanced and very configurable FTP server"
SRC_URI="ftp://ftp.proftpd.org/distrib/source/${MY_P}.tar.bz2
		shaper? http://www.castaglia.org/${PN}/modules/${PN}-mod-shaper-0.5.5.tar.gz
		http://www.castaglia.org/${PN}/modules/${PN}-mod-delay-0.4.tar.gz"
HOMEPAGE="http://www.proftpd.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~hppa ~alpha ppc ~mips ~amd64"

DEPEND="pam? ( >=sys-libs/pam-0.75 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.3 )
	ssl? ( >=dev-libs/openssl-0.9.6f )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r3 )"

RDEPEND="selinux? ( sec-policy/selinux-ftpd )"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	unpack ${PN}-mod-delay-0.4.tar.gz
	mv mod_delay/mod_delay.c contrib
	if use shaper; then
		unpack ${PN}-mod-shaper-0.5.5.tar.gz
		mv mod_shaper/mod_shaper.c contrib/
	fi
}

src_compile() {
	local modules myconf

	modules="mod_ratio:mod_readme:mod_delay"
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
		myconf="--with-includes=/usr/include/mysql"
	elif use postgres; then
		modules="${modules}:mod_sql:mod_sql_postgres"
		myconf="--with-includes=/usr/include/postgresql"
	fi

	if use softquota; then
		modules="${modules}:mod_quotatab"
		if use mysql || use postgres; then
			modules="${modules}:mod_quotatab_sql"
		elif use ldap; then
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

	econf \
		--sbindir=/usr/sbin \
		--localstatedir=/var/run \
		--sysconfdir=/etc/proftpd \
		--enable-shadow \
		--disable-sendfile \
		--enable-autoshadow \
		--enable-ctrls \
		--with-modules=${modules} \
		${myconf} $( use_enable ipv6 ) || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	# Note rundir needs to be specified to avoid sandbox violation
	# on initial install. See Make.rules
	make DESTDIR=${D} install || die

	keepdir /home/ftp
	keepdir /var/run/proftpd

	dodoc contrib/README.mod_sql ${FILESDIR}/proftpd.conf \
		COPYING CREDITS ChangeLog NEWS README* \
		doc/{license.txt,GetConf}
	dohtml doc/*.html
	dohtml mod_delay/mod_delay.html
	use shaper && dohtml mod_shaper/mod_shaper.html
	docinto rfc
	dodoc doc/rfc/*.txt

	mv ${D}/etc/proftpd/proftpd.conf ${D}/etc/proftpd/proftpd.conf.distrib

	insinto /etc/proftpd
	newins ${FILESDIR}/proftpd.conf proftpd.conf.sample

	if use pam; then
		insinto /etc/pam.d
		newins ${S}/contrib/dist/rpm/ftp.pamd ftp
	fi

	insinto /etc/xinetd.d
	newins ${FILESDIR}/proftpd.xinetd proftpd

	exeinto /etc/init.d ; newexe ${FILESDIR}/proftpd.rc6 proftpd
}

pkg_postinst() {
	groupadd proftpd &>/dev/null
	id proftpd &>/dev/null || \
		useradd -g proftpd -d /home/ftp -s /bin/false proftpd
	einfo
	einfo 'You can find the config files in /etc/proftpd'
	einfo
	einfo 'For info on the mod_delay please read mod_delay.html in the doc dir'
}
