# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/postfix/postfix-1.1.11-r5.ebuild,v 1.5 2002/08/30 14:41:00 raker Exp $

POSTFIX_TLS_VER="0.8.11a-${PV}-0.9.6d"
S=${WORKDIR}/${P}

DESCRIPTION="A fast and secure drop-in replacement for sendmail"
HOMEPAGE="http://www.postfix.org/"
SRC_URI="ftp://ftp.porcupine.org/mirrors/postfix-release/official/${P}.tar.gz
	ssl? ( ftp://ftp.aet.tu-cottbus.de/pub/postfix_tls/pfixtls-${POSTFIX_TLS_VER}.tar.gz )"

LICENSE="IPL-1"
SLOT="0"
KEYWORDS="x86 sparc sparc64 ppc"

PROVIDE="virtual/mta"
DEPEND=">=sys-libs/db-3.2
	>=dev-libs/libpcre-3.4
	sasl? ( >=dev-libs/cyrus-sasl-1.5.27 )
	ldap? ( >=net-nds/openldap-1.2 )
	mysql? ( >=dev-db/mysql-3.23.28 )
	ssl? ( >=dev-libs/openssl-0.9.6d )"
RDEPEND="${DEPEND} 
	>=net-mail/mailbase-0.00
	!virtual/mta"

postfix_installed=no

pkg_setup() {
	if ! grep -q ^postdrop: /etc/group ; then
		groupadd postdrop || die "problem adding group postdrop"
	fi

	# is there an existing postfix installation?
	if [ -d /etc/postfix ] ; then
		postfix_installed=yes
	fi
}

src_unpack() {
	unpack ${A}

	use ssl && ( \
		cd ${S}
		patch -p1 < ${WORKDIR}/pfixtls-${POSTFIX_TLS_VER}/pfixtls.diff || die
	)

	if [ "`use sasl`" ]
	then
		if [ -e /usr/include/sasl/sasl.h ]
		then
			# saslv2
			cd ${S}
			patch -p1 < ${FILESDIR}/postfix-1.1.11-saslv2.diff || die
		fi
	fi			

	cd ${S}/conf
	cp main.cf main.cf.orig
	sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" main.cf.orig > main.cf

	cd ${S}/src/global
	cp mail_params.h mail_params.h.orig
	sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" mail_params.h.orig > mail_params.h

	use mysql \
		&& CCARGS="${CCARGS} -DHAS_MYSQL -I/usr/include/mysql" \
		&& AUXLIBS="${AUXLIBS} -lmysqlclient -lm"

	use ldap \
		&& CCARGS="${CCARGS} -DHAS_LDAP" \
		&& AUXLIBS="${AUXLIBS} -lldap -llber"

	use ssl \
		&& CCARGS="${CCARGS} -DHAS_SSL" \
		&& AUXLIBS="${AUXLIBS} -lssl -lcrypto"

	# note: if sasl is built w/ pam, then postfix _MUST_ be built w/ pam
	use pam && AUXLIBS="${AUXLIBS} -lpam"

	# stuff we always want...
	CCARGS="${CCARGS} -I/usr/include -DHAS_PCRE"
	AUXLIBS="${AUXLIBS} -L/usr/lib -lpcre -ldl -lcrypt"
	if [ "`use sasl`" ]
	then
		if [ -e /usr/include/sasl.h ]
		then
			# saslv1 seems to be installed. To not break existing installations,
			# we use this
			AUXLIBS="${AUXLIBS} -lsasl"
			CCARGS="${CCARGS} -DUSE_SASL_AUTH"
		else
			# Seems to be saslv2
			AUXLIBS="${AUXLIBS} -lsasl2"
			CCARGS="${CCARGS} -I/usr/include/sasl -DUSE_SASL_AUTH"
		fi
	fi
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
	dodir /usr/bin /usr/sbin /usr/lib/postfix /etc/postfix/sample

	cd ${S}/bin
	dosbin post* sendmail
	chown root.postdrop ${D}/usr/sbin/{postdrop,postqueue}
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
	# Do NOT use a custom master.cf, or update it for each version from that
	# version's source, as it changes too much between versions!!!!
	#
	# azarah@gentoo.org (23 Jul 2002)
	#
	#doins ${FILESDIR}/main.cf ${FILESDIR}/master.cf ${FILESDIR}/saslpass || die
	doins ${FILESDIR}/main.cf ${S}/conf/master.cf ${FILESDIR}/saslpass || die

	exeinto /etc/init.d ; newexe ${FILESDIR}/postfix.rc6 postfix
	insinto /etc/pam.d ; newins ${FILESDIR}/smtp.pam smtp

	if [ "`use sasl`" ]
	then
		if [ -e /usr/include/sasl.h ]
		then
			# saslv1 seems to be installed.
			insinto /etc/sasl ; doins ${FILESDIR}/smtpd.conf
		fi
		if [ -e /usr/include/sasl/sasl.h ]
		then
			# saslv2 seems to be installed.
			insinto /etc/sasl2 ; doins ${FILESDIR}/smtpd.conf
		fi
	fi		
}

pkg_postinst() {
	install -d -m 0755 ${ROOT}/var/spool/postfix

	if [ "${postfix_installed}" = "yes" ] ; then
		ewarn "If you've upgraded from <postfix-1.1.8, you must update"
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

	if [ "`use sasl`" -a -e /usr/include/sasl.h ] ; then
		echo
		einfo "sasl v1 and sasl v2 seem to be installed. Because we don't"
		einfo "want to break existing installations, we use sasl v1."
		einfo "If you don't want this, unmerge sasl v1 and remerge postfix."
	fi
}
