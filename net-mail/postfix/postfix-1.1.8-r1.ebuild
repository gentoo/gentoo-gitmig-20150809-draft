# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/net-mail/postfix/postfix-1.1.8.ebuild,v 1.1 2002/05/14 03:49:25 woodchip Exp

DESCRIPTION="A fast and secure drop-in replacement for sendmail"
HOMEPAGE="http://www.postfix.org/"

POSTFIX_TLS_VER="0.8.8-${PV}-0.9.6d"

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.porcupine.org/mirrors/postfix-release/official/${P}.tar.gz
	ssl? ( ftp://ftp.aet.tu-cottbus.de/pub/postfix_tls/pfixtls-${POSTFIX_TLS_VER}.tar.gz )"

PROVIDE="virtual/mta"
DEPEND=">=sys-libs/db-3.2
	>=dev-libs/libpcre-3.4
	sasl? ( >=dev-libs/cyrus-sasl-1.5.27 )
	ldap? ( >=net-nds/openldap-1.2 )
	mysql? ( >=dev-db/mysql-3.23.28 )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	pam? ( sys-libs/pam )"
RDEPEND="${DEPEND} 
	>=net-mail/mailbase-0.00
	!virtual/mta"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="x86 sparc sparc64"

pkg_setup() {
	if ! grep -q ^postdrop: /etc/group ; then
		groupadd postdrop || die "problem adding group postdrop"
	fi
}

src_unpack() {
	unpack ${A}

	use ssl && ( \
		cd ${S}
		patch -p1 < ${WORKDIR}/pfixtls-${POSTFIX_TLS_VER}/pfixtls.diff || die
	)

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
		&& AUXLIBS="${AUXLIBS} -lssl"

	# note: if sasl is built w/ pam, then postfix _MUST_ be built w/ pam
	use pam && AUXLIBS="${AUXLIBS} -lpam"

	# stuff we always want...
	CCARGS="${CCARGS} -I/usr/include -DHAS_PCRE"
	AUXLIBS="${AUXLIBS} -L/usr/lib -lpcre -ldl -lcrypt"
	if [ "`use sasl`" ]
	then
		AUXLIBS="${AUXLIBS} -lsasl"
		CCARGS="${CCARGS} -DUSE_SASL_AUTH"
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
	doins ${FILESDIR}/main.cf master.cf || die

	exeinto /etc/init.d ; newexe ${FILESDIR}/postfix.rc6 postfix
	insinto /etc/pam.d ; newins ${FILESDIR}/smtp.pam smtp
	insinto /etc/sasl ; doins ${FILESDIR}/smtpd.conf
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
}
