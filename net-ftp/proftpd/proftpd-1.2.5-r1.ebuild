# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.2.5-r1.ebuild,v 1.15 2004/01/24 04:38:49 raker Exp $

IUSE="ldap pam postgres mysql"

S=${WORKDIR}/${P}
DESCRIPTION="An advanced and very configurable FTP server"
SRC_URI="ftp://ftp.proftpd.org/distrib/source/${P}.tar.bz2"
HOMEPAGE="http://www.proftpd.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="net-libs/libpcap
	pam? ( >=sys-libs/pam-0.75 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.1 )"

src_unpack() {

#Fix bug #3791

	unpack ${P}.tar.bz2
	cd ${WORKDIR}/${P}
	patch contrib/mod_sql_postgres.c < ${FILESDIR}/mod_sql_postgres.c.patch || die "config patch failed"
}

src_compile() {
	local modules myconf

	modules="mod_ratio:mod_readme:mod_linuxprivs"
	use pam && modules="${modules}:mod_pam"
	use ldap && modules="${modules}:mod_ldap"

	if [ "`use mysql`" ] ; then
		modules="${modules}:mod_sql:mod_sql_mysql"
	elif [ "`use postgres`" ] ; then
		modules="${modules}:mod_sql:mod_sql_postgres"
		myconf="--with-includes=/usr/include/postgresql"
	fi

	use ldap && export LDFLAGS="-lresolv"

	econf \
		--sbindir=/usr/sbin \
		--localstatedir=/var/run \
		--sysconfdir=/etc/proftpd \
		--enable-shadow \
		--disable-sendfile \
		--enable-autoshadow \
		--with-modules=${modules} \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {

	#Note rundir needs to be specified to avoid sanbox violation
	#on initial install. See Make.rules
	einstall \
		sbindir=${D}/usr/sbin \
		localstatedir=${D}/var/run \
		rundir=${D}/var/run/proftpd \
		sysconfdir=${D}/etc/proftpd \
		|| die

	#dobin contrib/genuser.pl
	dodir /home/ftp

	dodoc contrib/README.mod_sql ${FILESDIR}/proftpd.conf \
		COPYING CREDITS ChangeLog NEWS README* \
		doc/{API,license.txt,GetConf,ShowUndocumented} \
		doc/development.notes
	dohtml doc/*.html
	docinto rfc
	dodoc doc/rfc/*.txt

	cd ${D}/etc/proftpd
	mv proftpd.conf proftpd.conf.distrib

	insinto /etc/proftpd
	newins ${FILESDIR}/proftpd.conf proftpd.conf.sample

	if [ "`use pam`" ] ; then
		insinto /etc/pam.d
		newins ${S}/contrib/dist/rpm/ftp.pamd ftp
	fi

	exeinto /etc/init.d ; newexe ${FILESDIR}/proftpd.rc6 proftpd
}

pkg_postinst() {
	groupadd proftpd &>/dev/null
	id proftpd &>/dev/null || \
		useradd -g proftpd -d /home/ftp -s /bin/false proftpd
}
