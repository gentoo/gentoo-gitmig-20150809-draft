# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Gentoo System <system@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.2.4-r7.ebuild,v 1.3 2002/04/30 11:10:55 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An advanced and very configurable FTP server"
SRC_URI="ftp://www.linuxceptional.com/proftpd/distrib/source/${P}.tar.bz2"
HOMEPAGE="http://www.proftpd.net/"

DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.75 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.1 )"

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

	./configure \
		--prefix=/usr \
		--sbindir=/usr/sbin \
		--mandir=/usr/share/man \
		--localstatedir=/var/run \
		--sysconfdir=/etc/proftpd \
		--enable-shadow \
		--disable-sendfile \
		--enable-autoshadow \
		--with-modules=${modules} \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	make || die "compile problem"
}

src_install() {
	
	#Note rundir needs to be specified to avoid sanbox violation
	#on initial install. See Make.rules
	make \
		prefix=${D}/usr \
		sbindir=${D}/usr/sbin \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/run \
		rundir=${D}/var/run/proftpd \
		sysconfdir=${D}/etc/proftpd \
		install || die

	dobin contrib/genuser.pl
	dodir /home/ftp

	dodoc contrib/README.mod_sql ${FILESDIR}/proftpd.conf \
		COPYING CREDITS ChangeLog NEWS README* \
		doc/{API,Changes*,license.txt,GetConf} \
		doc/{ShowUndocumented,Undocumented.txt} \
		doc/development.notes
	dohtml *.html
	docinto rfc
	dodoc rfc/*.txt

	cd ${D}/etc/proftpd
	mv proftpd.conf proftpd.conf.distrib

	insinto /etc/proftpd
	newins ${FILESDIR}/proftpd.conf proftpd.conf.sample

	exeinto /etc/init.d ; newexe ${FILESDIR}/proftpd.rc6 proftpd
}
