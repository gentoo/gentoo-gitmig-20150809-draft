# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.2.8.ebuild,v 1.2 2003/04/17 17:17:32 mholzer Exp $

IUSE="ldap pam postgres mysql ssl tcpd"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An advanced and very configurable FTP server"
SRC_URI="ftp://ftp.proftpd.org/distrib/source/${MY_P}.tar.bz2"
HOMEPAGE="http://www.proftpd.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~hppa ~alpha ~ppc"

DEPEND="net-libs/libpcap
	pam? ( >=sys-libs/pam-0.75 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.1 )
	ssl? ( >=dev-libs/openssl-0.9.6f )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r3 )"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
}	


src_compile() {
	local modules myconf

	modules="mod_ratio:mod_readme"
	use pam && modules="${modules}:mod_auth_pam"
	use tcpd && modules="${modules}:mod_wrap"

	if use ldap; then 
		einfo ldap
		modules="${modules}:mod_ldap"
		export LDFLAGS="-lresolv"
	fi	

	if use ssl; then
		einfo ssl

		# enable mod_tls
		modules="${modules}:mod_tls"
	fi

	if use mysql; then
		modules="${modules}:mod_sql:mod_sql_mysql"
	elif use postgres; then
		modules="${modules}:mod_sql:mod_sql_postgres"
		myconf="--with-includes=/usr/include/postgresql"
	fi

	econf \
		--sbindir=/usr/sbin \
		--localstatedir=/var/run \
		--sysconfdir=/etc/proftpd \
		--enable-shadow \
		--disable-sendfile \
		--enable-autoshadow \
		--with-modules=${modules} \
		${myconf} || die "bad ./configure"

	make || die "compile problem"
}

src_install() {
	# Note rundir needs to be specified to avoid sandbox violation
	# on initial install. See Make.rules
	einstall \
		sbindir=${D}/usr/sbin \
		localstatedir=${D}/var/run \
		rundir=${D}/var/run/proftpd \
		sysconfdir=${D}/etc/proftpd \
		|| die

	keepdir /home/ftp
	keepdir /var/run/proftpd

	dodoc contrib/README.mod_sql ${FILESDIR}/proftpd.conf \
		COPYING CREDITS ChangeLog NEWS README* \
		doc/{license.txt,GetConf}
	dohtml doc/*.html
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
}
