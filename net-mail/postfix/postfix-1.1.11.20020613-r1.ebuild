# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/postfix/postfix-1.1.11.20020613-r1.ebuild,v 1.3 2002/08/15 22:53:00 raker Exp $

DESCRIPTION="A fast and secure drop-in replacement for sendmail"
HOMEPAGE="http://www.postfix.org/"

POSTFIX_VER="1.1.11-20020613"
S=${WORKDIR}/postfix-${POSTFIX_VER}
SRC_URI="ftp://ftp.porcupine.org/mirrors/postfix-release/experimental/postfix-${POSTFIX_VER}.tar.gz"

PROVIDE="virtual/mta"
DEPEND=">=sys-libs/db-3.2
	>=dev-libs/libpcre-3.4
	sasl? ( >=dev-libs/cyrus-sasl-2.1.6 )
	ldap? ( >=net-nds/openldap-1.2 )
	mysql? ( >=dev-db/mysql-3.23.28 )
	ssl? ( >=dev-libs/openssl-0.9.6e )
        pam? ( sys-libs/pam )"
RDEPEND="${DEPEND} 
	>=net-mail/mailbase-0.00
	!virtual/mta"
LICENSE="IPL-1"
SLOT="0"
KEYWORDS="*"

pkg_setup() {
	if ! grep -q ^postdrop: /etc/group ; then
		groupadd postdrop || die "problem adding group postdrop"
	fi
}

src_unpack() {
	unpack ${A}

	if [ "`use ipv6`" ] || [ "`use ssl`" ]
	then
		cd ${S}
		patch -p1 < ${FILESDIR}/tls+ipv6.diff || die
		cd ${WORKDIR}
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
		&& CCARGS="${CCARGS} -DHAS_SSL -I/usr/include/openssl" \
		&& AUXLIBS="${AUXLIBS} -lssl -lcrypto"

	# note: if sasl is built w/ pam, then postfix _MUST_ be built w/ pam
	use pam && AUXLIBS="${AUXLIBS} -lpam"

	# stuff we always want...
	CCARGS="${CCARGS} -I/usr/include -DHAS_PCRE"
	AUXLIBS="${AUXLIBS} -L/usr/lib -lpcre -ldl -lcrypt"

	if [ "`use sasl`" ]
	then
		AUXLIBS="${AUXLIBS} -lsasl2"
		CCARGS="${CCARGS} -DUSE_SASL_AUTH"
		cd ${S}
		patch -p1 < ${FILESDIR}/saslv2.diff
	fi

	DEBUG=""

	cd ${S}
	make tidy || die
	make makefiles CC="cc" OPT="${CFLAGS}" DEBUG="${DEBUG}" \
		CCARGS="${CCARGS}" AUXLIBS="${AUXLIBS}" || die
}

src_compile() {
	make || die "oooops"
}

src_install () {
	dodir /usr/bin /usr/sbin /usr/lib/postfix /etc/postfix/sample

	cd ${S}/bin
	dosbin post* sendmail
	chown root.postdrop ${D}/usr/sbin/{postdrop,postqueue}
	chmod 2755 ${D}/usr/sbin/{postdrop,postqueue}

	dosym /usr/sbin/sendmail /usr/bin/mail
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
	doins ${FILESDIR}/main.cf master.cf || die

	exeinto /etc/init.d ; newexe ${FILESDIR}/postfix.rc6 postfix
	insinto /etc/pam.d ; newins ${FILESDIR}/smtp.pam smtp
	insinto /etc/sasl2 ; doins ${FILESDIR}/smtpd.conf
}

pkg_postinst() {
	install -d 0755 ${ROOT}/var/spool/postfix

	einfo "***************************************************************"
	einfo "* NOTE: If config file protection is enabled and you upgraded *"
	einfo "*       from an earlier version of postfix you must update    *"
	einfo "*       /etc/postfix/master.cf to the latest version	     *"
	einfo "*       (/etc/postfix/._cfg????_master.cf). Otherwise postfix *"
	einfo "*       will not work correctly.                              *"
	einfo "***************************************************************"

	einfo "********************************************************"
	einfo "* First time installers: You must edit                 *"
	einfo "* /etc/mail/aliases to suit your needs and then run    *"
	einfo "* /usr/bin/newaliases. Postfix will not work correctly *"
	einfo "* without it                                           *"
	einfo "********************************************************"

}
