# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/exim/exim-4.24-r1.ebuild,v 1.3 2003/12/17 04:28:41 brad_mssw Exp $

IUSE="tcpd ssl postgres mysql ldap pam exiscan-acl maildir lmtp ipv6 sasl"

EXISCANACL_VER=${PV}-13

DESCRIPTION="A highly configurable, drop-in replacement for sendmail"
SRC_URI="ftp://ftp.exim.org/pub/exim/exim4/${P}.tar.gz
	exiscan-acl? ( http://duncanthrax.net/exiscan-acl/exiscan-acl-${EXISCANACL_VER}.patch )"
HOMEPAGE="http://www.exim.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~hppa ppc ~amd64 ppc64"

PROVIDE="virtual/mta"
DEPEND=">=sys-apps/sed-4.0.5
	dev-lang/perl
	>=sys-libs/db-3.2
	>=dev-libs/libpcre-3.4
	pam? ( >=sys-libs/pam-0.75 )
	tcpd? ( sys-apps/tcp-wrappers )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	ldap? ( >=net-nds/openldap-2.0.7 )
	mysql? ( >=dev-db/mysql-3.23.28 )
	postgres? ( >=dev-db/postgresql-7 )
	sasl? ( >=dev-libs/cyrus-sasl-2.1.14 )"
RDEPEND="${DEPEND}
	!virtual/mta
	>=net-mail/mailbase-0.00-r5"

src_unpack() {
	unpack ${A}
	cd ${S}

	local myconf

	epatch ${FILESDIR}/exim-4.14-tail.patch

	if use maildir; then
		einfo "Patching maildir support into exim.conf"
		epatch ${FILESDIR}/exim-4.20-maildir.patch
	fi

	sed -i "/SYSTEM_ALIASES_FILE/ s'SYSTEM_ALIASES_FILE'/etc/mail/aliases'" ${S}/src/configure.default
	cp ${S}/src/configure.default ${S}/src/configure.default.orig

	if use exiscan-acl; then
		einfo "Patching exican-acl support into exim ${PV}.."
		epatch ${DISTDIR}/exiscan-acl-${EXISCANACL_VER}.patch
	fi

	sed -e "48i\CFLAGS=${CFLAGS}" \
		-e "s:# AUTH_CRAM_MD5=yes:AUTH_CRAM_MD5=yes:" \
		-e "s:# AUTH_PLAINTEXT=yes:AUTH_PLAINTEXT=yes:" \
		-e "s:BIN_DIRECTORY=/usr/exim/bin:BIN_DIRECTORY=/usr/sbin:" \
		-e "s:COMPRESS_COMMAND=/opt/gnu/bin/gzip:COMPRESS_COMMAND=/usr/bin/gzip:" \
		-e "s:ZCAT_COMMAND=/opt/gnu/bin/zcat:ZCAT_COMMAND=/usr/bin/zcat:" \
		-e "s:CONFIGURE_FILE=/usr/exim/configure:CONFIGURE_FILE=/etc/exim/exim.conf:" \
		-e "s:EXIM_MONITOR=eximon.bin:# EXIM_MONITOR=eximon.bin:" \
		-e "s:# EXIM_PERL=perl.o:EXIM_PERL=perl.o:" \
		-e "s:# INFO_DIRECTORY=/usr/local/info:INFO_DIRECTORY=/usr/share/info:" \
		-e "s:# LOG_FILE_PATH=/var/log/exim_%slog:LOG_FILE_PATH=/var/log/exim/exim_%s.log:" \
		-e "s:# PID_FILE_PATH=/var/lock/exim.pid:PID_FILE_PATH=/var/run/exim.pid:" \
		-e "s:# SPOOL_DIRECTORY=/var/spool/exim:SPOOL_DIRECTORY=/var/spool/exim:" \
		-e "s:# SUPPORT_MAILDIR=yes:SUPPORT_MAILDIR=yes:" \
		-e "s:# SUPPORT_MAILSTOR=yes:SUPPORT_MAILSTORE=yes:" \
		-e "s:# SUPPORT_MBX=yes:SUPPORT_MBX=yes:" \
		-e "s:EXIM_USER=:EXIM_USER=mail:" \
		-e "s:# AUTH_SPA=yes:AUTH_SPA=yes:" \
		src/EDITME > Local/Makefile

	cd Local
	if use pam; then
		sed -i "s:# \(SUPPORT_PAM=yes\):\1:" Makefile
		myconf="${myconf} -lpam"
	fi
	if use sasl; then
		sed -i "s:# CYRUS_SASLAUTHD_SOCKET=/var/state/saslauthd/mux:CYRUS_SASLAUTHD_SOCKET=/var/lib/sasl2/mux:" \
		Makefile
		myconf="${myconf} -lsasl2"
	fi
	if use tcpd; then
		sed -i "s:# \(USE_TCP_WRAPPERS=yes\):\1:" Makefile
		myconf="${myconf} -lwrap"
	fi
	if use lmtp; then
		sed -i "s:# \(TRANSPORT_LMTP=yes\):\1:" Makefile
	fi
	if use ipv6; then
		echo "HAVE_IPV6=YES" >> Makefile
	fi

	if [ -n "$myconf" ] ; then
		echo "EXTRALIBS=${myconf}" >> Makefile
	fi

	cd ${S}
	if use ssl; then
		sed -i \
			-e "s:# \(SUPPORT_TLS=yes\):\1:" \
			-e "s:# \(TLS_LIBS=-lssl -lcrypto\):\1:" Local/Makefile
	fi

	LOOKUP_INCLUDE=
	LOOKUP_LIBS=

	if use ldap; then
		sed -i \
			-e "s:# \(LOOKUP_LDAP=yes\):\1:" \
			-e "s:# \(LDAP_LIB_TYPE=OPENLDAP2\):\1:" Local/Makefile
		LOOKUP_INCLUDE="-I/usr/include/ldap"
		LOOKUP_LIBS="-L/usr/lib -lldap -llber"
	fi

	if use mysql; then
		sed -i "s:# LOOKUP_MYSQL=yes:LOOKUP_MYSQL=yes:" Local/Makefile
		LOOKUP_INCLUDE="$LOOKUP_INCLUDE -I/usr/include/mysql"
		LOOKUP_LIBS="$LOOKUP_LIBS -L/usr/lib -lmysqlclient"
	fi

	if use postgres; then
		sed -i "s:# LOOKUP_PGSQL=yes:LOOKUP_PGSQL=yes:" Local/Makefile
		LOOKUP_INCLUDE="$LOOKUP_INCLUDE -I/usr/include/postgresql"
		LOOKUP_LIBS="$LOOKUP_LIBS -lpq"
	fi

	if [ -n "$LOOKUP_INCLUDE" ]; then
		sed -i "s:# LOOKUP_INCLUDE=-I /usr/local/ldap/include -I /usr/local/mysql/include -I /usr/local/pgsql/include:LOOKUP_INCLUDE=$LOOKUP_INCLUDE:" \
			Local/Makefile
	fi

	if [ -n "$LOOKUP_LIBS" ]; then
		sed -i "s:# LOOKUP_LIBS=-L/usr/local/lib -lldap -llber -lmysqlclient -lpq -lgds:LOOKUP_LIBS=$LOOKUP_LIBS:" \
			Local/Makefile
	fi


	cat Makefile | sed -e 's/^buildname=.*/buildname=exim-gentoo/g' > Makefile.gentoo && mv -f Makefile.gentoo Makefile

	sed -i "s:# LOOKUP_DSEARCH=yes:LOOKUP_DSEARCH=yes:" Local/Makefile

	sed -i "s:# LOOKUP_CDB=yes:LOOKUP_CDB=yes:" Local/Makefile

	# Use the "native" interface to the DBM library
	echo "USE_DB=yes" >> ${S}/Local/Makefile
}

src_compile() {
	make || die "make failed"
}


src_install () {
	cd ${S}/build-exim-gentoo
	exeinto /usr/sbin
	doexe exim
	fperms 4755 /usr/sbin/exim

	dodir /usr/bin /usr/sbin /usr/lib
	dosym ../sbin/exim /usr/bin/mailq
	dosym ../sbin/exim /usr/bin/newaliases
	dosym ../sbin/exim /usr/bin/mail
	dosym exim /usr/sbin/rsmtp
	dosym exim /usr/sbin/rmail
	dosym exim /usr/sbin/sendmail
	dosym ../sbin/exim /usr/lib/sendmail

	exeinto /usr/sbin
	for i in exicyclog exim_dbmbuild exim_dumpdb exim_fixdb exim_lock \
		exim_tidydb exinext exiwhat exigrep eximstats exiqsumm \
		convert4r3 convert4r4
	do
		doexe $i
	done

	dodoc ${S}/doc/*
	doman ${S}/doc/exim.8

	# conf files
	insinto /etc/exim
	newins ${S}/src/configure.default.orig exim.conf.dist
	if use exiscan-acl; then
		newins ${S}/src/configure.default exim.conf.exiscan-acl
	fi
	doins ${FILESDIR}/system_filter.exim
	doins ${FILESDIR}/auth_conf.sub
	if use exiscan; then
		newins ${S}/src/configure.default exim.conf.exiscan
		doins ${FILESDIR}/exiscan.conf
	fi

	# INSTALL a pam.d file for SMTP AUTH that works with gentoo's pam
	insinto /etc/pam.d
	newins ${FILESDIR}/pam.d-exim exim

	exeinto /etc/init.d
	newexe ${FILESDIR}/exim.rc6 exim

	insinto /etc/conf.d
	newins ${FILESDIR}/exim.confd exim

	DIROPTIONS="--mode=0750 --owner=mail --group=mail"
	dodir /var/log/${PN}
}


pkg_postinst() {
	einfo "/etc/exim/system_filter.exim is a sample system_filter."
	einfo "/etc/exim/auth_conf.sub contains the configuration sub for using smtp auth."
	einfo "Please create /etc/exim/exim.conf from /etc/exim/exim.conf.dist."
}


