# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/exim/exim-3.36-r2.ebuild,v 1.5 2002/08/14 12:05:25 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A highly configurable, drop-in replacement for sendmail"
SRC_URI="ftp://ftp.exim.org/pub/exim/exim3/${P}.tar.gz"
HOMEPAGE="http://www.exim.org/"

DEPEND="virtual/glibc
		>=sys-libs/db-3.2
		>=sys-devel/perl-5.6.0
		>=dev-libs/libpcre-3.4
		pam? ( >=sys-libs/pam-0.75 )
		tcpd? ( sys-apps/tcp-wrappers )
		mta-tls? ( >=dev-libs/openssl-0.9.6 )
		mta-ldap? ( >=net-nds/openldap-2.0.7 )
		mta-mysql? ( >=dev-db/mysql-3.23.28 )"

RDEPEND="${DEPEND}
		 !virtual/mta
		 >=net-mail/mailbase-0.00"

PROVIDE="virtual/mta"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_unpack() {

	local myconf
	unpack ${A}
	cd ${S}

	mkdir Local
	sed -e "48i\CFLAGS=${CFLAGS}" \
		-e "s:# AUTH_CRAM_MD5=yes:AUTH_CRAM_MD5=yes:" \
		-e "s:# AUTH_PLAINTEXT=yes:AUTH_PLAINTEXT=yes:" \
		-e "s:BIN_DIRECTORY=/usr/exim/bin:BIN_DIRECTORY=/usr/sbin:" \
		-e "s:COMPRESS_COMMAND=/opt/gnu/bin/gzip:COMPRESS_COMMAND=/usr/bin/gzip:" \
		-e "s:ZCAT_COMMAND=/opt/gnu/bin/zcat:ZCAT_COMMAND=/usr/bin/zcat:" \
		-e "s:CONFIGURE_FILE=/usr/exim/configure:CONFIGURE_FILE=/etc/exim/configure:" \
		-e "s:EXIM_MONITOR=eximon.bin:# EXIM_MONITOR=eximon.bin:" \
		-e "s:# EXIM_PERL=perl.o:EXIM_PERL=perl.o:" \
		-e "s:# INFO_DIRECTORY=/usr/local/info:INFO_DIRECTORY=/usr/share/info:" \
		-e "s:# LOG_FILE_PATH=syslog:LOG_FILE_PATH=syslog:" \
		-e "s:# PID_FILE_PATH=/var/lock/exim%s.pid:PID_FILE_PATH=/var/run/exim%s.pid:" \
		-e "s:# SPOOL_DIRECTORY=/var/spool/exim:SPOOL_DIRECTORY=/var/spool/exim:" \
		-e "s:# SUPPORT_MAILDIR=yes:SUPPORT_MAILDIR=yes:" \
		src/EDITME > Local/Makefile

	cd Local
	if use pam; then
		cp Makefile Makefile.orig
		sed -e "s:# SUPPORT_PAM=yes:SUPPORT_PAM=yes:" Makefile.orig > Makefile
		myconf="${myconf} -lpam"
	fi
	if use tcpd; then
		cp Makefile Makefile.orig
		sed -e "s:# USE_TCP_WRAPPERS=yes:USE_TCP_WRAPPERS=yes:" Makefile.orig > Makefile
		myconf="${myconf} -lwrap"
	fi
	if [ -n "$myconf" ] ; then
		echo "EXTRALIBS=${myconf}" >> Makefile
	fi

	cd ${S}
	if use mta-tls; then
		cp Local/Makefile Local/Makefile.tmp
		sed -e "s:# SUPPORT_TLS=yes:SUPPORT_TLS=yes:" \
			-e "s:# TLS_LIBS=-lssl -lcrypto:TLS_LIBS=-lssl -lcrypto:" Local/Makefile.tmp > Local/Makefile
	fi
	if use mta-ldap; then
		cp Local/Makefile Local/Makefile.tmp
		sed -e "s:# LOOKUP_LDAP=yes:LOOKUP_LDAP=yes:" \
			-e "s:# LOOKUP_INCLUDE=-I /usr/local/ldap/include -I /usr/local/mysql/include -I /usr/local/pgsql/include:LOOKUP_INCLUDE=-I/usr/include/ldap :" \
			-e "s:# LOOKUP_LIBS=-L/usr/local/lib -lldap -llber -lmysqlclient -lpq:LOOKUP_LIBS=-L/usr/lib -lldap -llber :" \
			-e "s:# LDAP_LIB_TYPE=OPENLDAP2:LDAP_LIB_TYPE=OPENLDAP2:" Local/Makefile.tmp >| Local/Makefile
	fi
	if use mta-mysql; then
		cp Local/Makefile Local/Makefile.tmp
		sed -e "s:# LOOKUP_MYSQL=yes:LOOKUP_MYSQL=yes:" \
			-e "s:# LOOKUP_LIBS=-L/usr/local/lib -lldap -llber -lmysqlclient -lpq:LOOKUP_LIBS=-L/usr/lib -lldap -llber -lmysqlclient -lpq:" Local/Makefile.tmp >| Local/Makefile
	fi
	cat Makefile | sed -e 's/^buildname=.*/buildname=exim-gentoo/g' > Makefile.gentoo && mv -f Makefile.gentoo Makefile
}


src_compile() {
	make || die
}


src_install () {

	cd ${S}/build-exim-gentoo
	insopts -o root -g root -m 4755
	insinto /usr/sbin
	doins exim

	dodir /usr/bin /usr/sbin /usr/lib
	dosym /usr/sbin/exim /usr/bin/mailq
	dosym /usr/sbin/exim /usr/bin/newaliases
	dosym /usr/sbin/exim /usr/bin/mail
	dosym /usr/sbin/exim /usr/lib/sendmail
	dosym /usr/sbin/exim /usr/sbin/sendmail

	exeinto /usr/sbin
	for i in exicyclog exim_dbmbuild exim_dumpdb exim_fixdb exim_lock exim_tidydb exinext exiwhat
	do
		doexe $i
	done

	cd ${S}/util
	exeinto /usr/sbin
	for i in exigrep eximstats exiqsumm
	do
		doexe $i
	done

	dodir /etc/exim /etc/exim/samples

	insopts -o root -g root -m 0644
	insinto /etc/exim
	doins ${FILESDIR}/configure

	cd ${S}/src
	insopts -o root -g root -m 0644
	insinto /etc/exim/samples
	doins configure.default

	dodoc ${S}/doc/*

	# INSTALL a pam.d file for SMTP AUTH that works with gentoo's pam
	insinto /etc/pam.d
	doins ${FILESDIR}/pam.d-exim

	# A nice filter for exim to protect your windows clients.
	insinto /etc/exim
	doins ${FILESDIR}/system_filter.exim
	einfo "Read the bottom of /etc/exim/system_filter.exim for usage"
	dodoc ${FILESDIR}/auth_conf.sub
	einfo "Cat this to the end of your configure for AUTH=PAM support"
	# FIXME The above messages should be moved into pkg_postinst !!!

	exeinto /etc/init.d
	newexe ${FILESDIR}/exim.rc6 exim
	insinto /etc/conf.d
	newins ${FILESDIR}/exim.confd exim
}


pkg_config() {

	${ROOT}/usr/sbin/rc-update add exim
}
