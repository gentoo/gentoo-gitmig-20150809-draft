# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Jerry Alexandratos <jerry@gentoo.org>, Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/postfix/postfix-1.1.2-r1.ebuild,v 1.1 2002/01/26 21:56:25 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A fast and secure drop-in replacement for sendmail"
SRC_URI="ftp://ftp.porcupine.org/mirrors/postfix-release/official/${P}.tar.gz"
HOMEPAGE="http://www.postfix.org/"

PROVIDE="virtual/mta"

DEPEND="virtual/glibc
	>=dev-libs/libpcre-3.4
	>=sys-libs/db-3.2
	mta-ldap? ( >=net-nds/openldap-1.2 )
	mta-mysql? ( >=dev-db/mysql-3.23.28 )"

RDEPEND="${DEPEND}
	>=net-mail/mailbase-0.00
	!virtual/mta"

src_unpack() {

	unpack ${A}
	cd ${S}/conf
	cp main.cf main.cf.orig
	sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" main.cf.orig > main.cf

	cd ${S}/src/global
	cp mail_params.h mail_params.h.orig
	sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" mail_params.h.orig > mail_params.h

	use mta-ldap && ( CCARGS="${CCARGS} -DHAS_LDAP" ; AUXLIBS="${AUXLIBS} -lldap -llber" )
	use mta-mysql && ( CCARGS="${CCARGS} -DHAS_MYSQL" ; AUXLIBS="${AUXLIBS} -lmysqlclient -lm" )

	CCARGS="-I/usr/include -DHAS_PCRE" ; AUXLIBS="-L/usr/lib -lpcre"

	cd ${S} ; make makefiles CC="cc ${CFLAGS} ${CCARGS} ${AUXLIBS}" || die
}

src_compile() {

	emake || die "compile problem"
}

src_install () {

	dodir /usr/bin /usr/sbin /usr/lib/postfix /etc/postfix/sample
	dodir /var/spool/postfix /var/spool/postfix/maildrop
	fowners postfix.root /var/spool/postfix/maildrop
	fperms 1733 /var/spool/postfix/maildrop

	cd ${S}/bin ; dosbin post* sendmail
	dosym /usr/sbin/sendmail /usr/bin/mail
	dosym /usr/sbin/sendmail /usr/bin/mailq
	dosym /usr/sbin/sendmail /usr/bin/newaliases
	dosym /usr/sbin/sendmail /usr/lib/sendmail
	cd ${S}/libexec ; exeinto /usr/lib/postfix ; doexe *
	cd ${S}/man ; doman man*/*

	cd ${S}
	dodoc *README COMPATIBILITY HISTORY LICENSE PORTING RELEASE_NOTES
	docinto html ; dodoc html/*

	cd ${S}/conf
	insinto /etc/postfix/sample
	doins access aliases canonical relocated transport
	doins pcre_table regexp_table postfix-script* *.cf
	exeinto /etc/postfix
	doexe postfix-script post-install postfix-files || die
	insinto /etc/postfix
	doins ${FILESDIR}/main.cf master.cf || die

	exeinto /etc/init.d ; newexe ${FILESDIR}/postfix.rc6 postfix
}

pkg_postinst() {
	echo
	echo "***************************************************************"
	echo "* NOTE:  Please add the 'postdrop' group, and also be sure    *"
	echo "*        to update /etc/postfix/master.cf to the latest       *"
	echo "*        as postfix 1.1.2's is not compadible with earlier    *"
	echo "*        versions.                                            *"
	echo "***************************************************************"
	echo
}
