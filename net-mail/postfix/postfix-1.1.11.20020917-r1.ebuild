# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/postfix/postfix-1.1.11.20020917-r1.ebuild,v 1.7 2003/12/14 22:59:41 spider Exp $

IUSE="ssl mysql sasl ldap ipv6"

PF_PV=1.1.11-20020917
PF_P=postfix-${PF_PV}
S=${WORKDIR}/${PF_P}
TLS_P=pfixtls-0.8.11a-${PF_PV}-0.9.6g
IPV6_P=tls+ipv6-1.4-pf-${PF_PV}

DESCRIPTION="A fast and secure drop-in replacement for sendmail"
HOMEPAGE="http://www.postfix.org/"
SRC_URI="ftp://ftp.aet.tu-cottbus.de/pub/postfix_tls/related/postfix/${PF_P}.tar.gz
	ssl? ( ftp://ftp.aet.tu-cottbus.de/pub/postfix_tls/${TLS_P}.tar.gz )"

LICENSE="IPL-1"
SLOT="0"
KEYWORDS="x86 ~sparc ~alpha ~ppc"

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

postfix_installed=no

pkg_setup() {

	if ! grep -q ^postdrop: /etc/group ; then
		groupadd postdrop || die "problem adding group postdrop"
	fi

	if [ -d /etc/postfix ] ; then
		postfix_installed=yes
	fi

}

src_unpack() {

	cd ${WORKDIR}
	unpack ${DISTFILES}/${PF_P}.tar.gz

	if [ `use ssl` ] && [ `use ipv6` ]
	then
		cd ${S}
		bzcat ${FILESDIR}/${IPV6_P}.patch.bz2 | patch -p1 || die "patch failed"
		CCARGS="${CCARGS} -DHAS_SSL"
		AUXLIBS="${AUXLIBS} -lssl -lcrypto"
	elif [ `use ssl` ]
	then
		unpack ${DISTFILES}/${TLS_P}.tar.gz
		cd ${S}
		patch -p1 < ${WORKDIR}/${TLS_P}/pfixtls.diff || die "patch failed"
		CCARGS="${CCARGS} -DHAS_SSL"
		AUXLIBS="${AUXLIBS} -lssl -lcrypto"
	fi

	cd ${S}/conf
	cp main.cf main.cf.orig
	sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" main.cf.orig > main.cf

	if [ "`use sasl`" ]
	then
			if [ -e /usr/include/sasl/sasl.h ]
			then
					# saslv2
					AUXLIBS="${AUXLIBS} -lsasl2"
					CCARGS="${CCARGS} -I/usr/include/sasl -DUSE_SASL_AUTH"
			else
					# saslv1
					AUXLIBS="${AUXLIBS} -lsasl"
					CCARGS="${CCARGS} -DUSE_SASL_AUTH"
			fi
	fi

	cd ${S}/src/global
	cp mail_params.h mail_params.h.orig
	sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" mail_params.h.orig > mail_params.h

	use mysql && CCARGS="${CCARGS} -DHAS_MYSQL -I/usr/include/mysql" \
		&& AUXLIBS="${AUXLIBS} -lmysqlclient -lm"

	use ldap && CCARGS="${CCARGS} -DHAS_LDAP" \
		&& AUXLIBS="${AUXLIBS} -lldap -llber"

	use pam && AUXLIBS="${AUXLIBS} -lpam"

	CCARGS="${CCARGS} -DHAS_PCRE"
	AUXLIBS="${AUXLIBS} -L/usr/lib -lpcre -ldl -lcrypt"
	DEBUG=""

	cd ${S}
	make tidy || die
	make makefiles CC="cc" OPT="${CFLAGS}" DEBUG="${DEBUG}" \
		CCARGS="${CCARGS}" AUXLIBS="${AUXLIBS}" || die
}

src_compile() {

	emake || die "compile problem"

}

src_install () {

	dodir /usr/bin /usr/sbin /usr/lib/postfix /etc/postfix/sample \
		/var/spool/postfix/hold

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
	dodoc *README COMPATIBILITY HISTORY LICENSE PORTING RELEASE_NOTES INSTALL
	dohtml html/*

	cd ${S}/conf
	insinto /etc/postfix/sample
	doins access aliases canonical relocated transport \
		pcre_table regexp_table postfix-script* *.cf

	exeinto /etc/postfix
	doexe postfix-script post-install postfix-files || die

	insinto /etc/postfix
	doins ${FILESDIR}/main.cf ${S}/conf/master.cf ${FILESDIR}/saslpass || die

	exeinto /etc/init.d ; newexe ${FILESDIR}/postfix.rc6 postfix
	insinto /etc/pam.d ; newins ${FILESDIR}/smtp.pam smtp

	if [ "`use sasl`" ]
	then
			if [ -e /usr/include/sasl.h ]
			then
					# saslv1
					insinto /etc/sasl ; doins ${FILESDIR}/smtpd.conf
			fi
			if [ -e /usr/include/sasl/sasl.h ]
			then
					# saslv2
					insinto /usr/lib/sasl2 ; doins ${FILESDIR}/smtpd.conf
			fi
	fi

}

pkg_postinst() {

	install -d -m 0755 ${ROOT}/var/spool/postfix

	if [ "${postfix_installed}" = "yes" ] ; then
		ewarn "If you have upgraded from <postfix-1.1.8, you must update"
		ewarn "/etc/postfix/master.cf to the latest version"
		ewarn "(/etc/postfix/._cfg*_master.cf). Otherwise Postfix will"
		ewarn "not work correctly."
	fi

	if [ ! -e /etc/mail/aliases.db ] ; then
		echo
		ewarn "You must edit /etc/mail/aliases to suit your needs"
		ewarn "and then run /usr/bin/newaliases. Postfix will not"
		ewarn "work correctly without it."
	fi

}
