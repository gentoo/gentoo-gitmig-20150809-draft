# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/postfix/postfix-2.0.9.ebuild,v 1.2 2003/04/19 02:55:27 drobbins Exp $

inherit eutils

TLS_P="pfixtls-0.8.13-2.0.6-0.9.7a"
IPV6_P="tls+ipv6-1.13-pf-2.0.7"
IUSE="ssl mysql sasl ldap ipv6 maildir mbox"
DESCRIPTION="A fast and secure drop-in replacement for sendmail"
HOMEPAGE="http://www.postfix.org"
SRC_URI="ftp://ftp.porcupine.org/mirrors/postfix-release/official/${P}.tar.gz
	ssl? ( ftp://ftp.aet.tu-cottbus.de/pub/postfix_tls/${TLS_P}.tar.gz )
	ipv6? ( ftp://ftp.stack.nl/pub/postfix/tls+ipv6/1.13/${IPV6_P}.patch.gz )"
LICENSE="IPL-1"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
PROVIDE="virtual/mta
	 virtual/mda"
DEPEND=">=sys-libs/db-3.2
	>=dev-libs/libpcre-3.4
	ldap? ( >=net-nds/openldap-1.2 )
	mysql? ( >=dev-db/mysql-3.23.51 )
	ssl? ( >=dev-libs/openssl-0.9.6g )
	sasl? ( dev-libs/cyrus-sasl )"
RDEPEND="${DEPEND}
	>=net-mail/mailbase-0.00
	!virtual/mta"

is_postfix_installed() {
	if [ -d /etc/postfix ] ; then
		return 1
	fi

	return 0
}

pkg_setup() {
	if ! grep -q ^postdrop: /etc/group ; then
		groupadd postdrop || die "problem adding group postdrop"
	fi

	if ! grep -q ^mail:.*postfix /etc/group ; then
		usermod -G mail postfix || die "problem adding user postfix to group mail"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ "`use ssl`" ] && [ "`use ipv6`" ]; then
		patch ${WORKDIR}/${IPV6_P}.patch < ${FILESDIR}/postfix-2.0.8_patch.patch || die
		epatch ${WORKDIR}/${IPV6_P}.patch || die
		CCARGS="${CCARGS} -DHAS_SSL"
		AUXLIBS="${AUXLIBS} -lssl -lcrypto"
	elif [ "`use ssl`" ]; then
		epatch ${WORKDIR}/${TLS_P}/pfixtls.diff || die
		CCARGS="${CCARGS} -DHAS_SSL"
		AUXLIBS="${AUXLIBS} -lssl -lcrypto"
	fi
	cd ${S}/conf
	cp main.cf main.cf.orig
	sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" \
		< main.cf.orig > main.cf

	if [ "`use sasl`" ] ; then
		# sasl 2
		if [ -f /usr/include/sasl/sasl.h ]; then
			AUXLIBS="${AUXLIBS} -lsasl2"
			CCARGS="${CCARGS} -I/usr/include/sasl -DUSE_SASL_AUTH"
		# sasl 1
		elif [ -f /usr/include/sasl.h ]; then
			AUXLIBS="${AUXLIBS} -lsasl"
			CCARGS="${CCARGS} -DUSE_SASL_AUTH"
		fi
	fi

	cd ${S}/src/global
	mv mail_params.h mail_params.h.orig
	sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" \
		< mail_params.h.orig > mail_params.h

	if [ "`use mysql`" ] ; then
		CCARGS="${CCARGS} -DHAS_MYSQL -I/usr/include/mysql"
		AUXLIBS="${AUXLIBS} -lmysqlclient -lm -lz"
	fi

	if [ "`use ldap`" ] ; then
		CCARGS="${CCARGS} -DHAS_LDAP"
		AUXLIBS="${AUXLIBS} -lldap -llber"
	fi

	if [ "`use pam`" ] ; then
		AUXLIBS="${AUXLIBS} -lpam"
	fi

	CCARGS="${CCARGS} -DHAS_PCRE"
	AUXLIBS="${AUXLIBS} -L/usr/lib -lpcre -ldl -lcrypt"

	DEBUG=""

	cd ${S}
	make makefiles CC="${CC}" OPT="${CFLAGS}" DEBUG="${DEBUG}" \
		CCARGS="${CCARGS}" AUXLIBS="${AUXLIBS}" \
		|| die "creating makefiles failed"
}

src_compile() {
	#this is a bug fix for gcc-2.95.3-r5 (bug 16547)
	export CC=gcc
	emake || die "compile problem"
}

src_install () {
	dodir /usr/bin /usr/sbin /usr/lib/postfix /etc/postfix/sample \
		/var/spool/postfix/tmp
	touch ${D}/var/spool/postfix/.keep

	cd ${S}/bin
	dosbin post* sendmail
	chown root:postdrop ${D}/usr/sbin/{postdrop,postqueue}
	chmod 2755 ${D}/usr/sbin/{postdrop,postqueue}

	dosym /usr/sbin/sendmail /usr/bin/mailq
	dosym /usr/sbin/sendmail /usr/bin/newaliases
	dosym /usr/sbin/sendmail /usr/lib/sendmail

	cd ${S}/libexec
	exeinto /usr/lib/postfix
	doexe *

	cd ${S}/man
	doman man*/*

	cd ${S}
	dodoc *README COMPATIBILITY HISTORY INSTALL LICENSE PORTING RELEASE_NOTES*
	cd README_FILES
	find . -type l |xargs rm
	dodoc *

	cd ${S}
	dohtml html/*

	cd ${S}/conf
	insinto /etc/postfix/sample
	doins access aliases canonical pcre_table regexp_table \
		relocated transport virtual *.cf

	exeinto /etc/postfix
	doexe postfix-script post-install postfix-files

	insinto /etc/postfix
	doins ${S}/conf/{main,master}.cf ${FILESDIR}/saslpass
	cd ${D}/etc/postfix
	epatch ${FILESDIR}/postfix-2.0.0/main.cf.diff
	mv main.cf main.cf.orig
	sed <main.cf.orig >main.cf \
		-e "s|/usr/share/doc/POSTFIX|/usr/share/doc/${PF}|"
	chmod 644 main.cf
	rm main.cf.orig
	fperms 600 /etc/postfix/saslpass

	exeinto /etc/init.d ; doexe ${FILESDIR}/postfix
	insinto /etc/pam.d ; newins ${FILESDIR}/smtp.pam smtp

	if [ "`use sasl`" ] ; then
		# sasl 2
		if [ -f /usr/include/sasl/sasl.h ] ; then
			insinto /usr/lib/sasl2
			doins ${FILESDIR}/smtpd.conf
		else
			insinto /etc/sasl
			doins ${FILESDIR}/smtpd.conf
		fi
	fi
	cd ${D}/etc/postfix
	if [ "`use maildir`" ]; then
		cp main.cf main.cf.premaildir
		sed -e "s:#home_mailbox = Maildir/:home_mailbox = .maildir/:" \
			< main.cf.premaildir > main.cf
		rm main.cf.premaildir
	elif [ "`use mbox`" ]; then
		cp main.cf main.cf.prembox
		sed -e "s:#mail_spool_directory = /var/spool/mail:mail_spool_directory = /var/spool/mail:" \
			< main.cf.prembox > main.cf
		rm main.cf.prembox
	fi
	rm main.cf~

	#install an rmail for UUCP, closing bug #19127
	cd ${S}/auxiliary/rmail
	dobin rmail
}

pkg_postinst() {
	install -d -m 0755 ${ROOT}/var/spool/postfix

	ewarn "If you upgraded from <postfix-2, you must revisit your configuration files."
	ewarn "See /usr/share/doc/${PF}/RELEASE_NOTES for a list of changes."

	if [ ! -e /etc/mail/aliases.db ] ; then
		echo
		ewarn "You must edit /etc/mail/aliases to suit your needs and then run"
		ewarn "/usr/bin/newaliases. Postfix will not work correctly without it."
	fi
}
