# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/postfix/postfix-20010228.2-r1.ebuild,v 1.2 2001/05/30 18:24:34 achim Exp $

P=${PN}-20010228-pl02
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A fast and secure drop-in replacement for sendmail"
SRC_URI="ftp://ftp.porcupine.org/mirrors/postfix-release/official/${A}"
HOMEPAGE="http://www.postfix.org/"

DEPEND="virtual/glibc
        >=dev-libs/libpcre-3.4
        >=sys-libs/db-3.2
        mta-ldap? ( >=net-nds/openldap-1.2 )
        mta-mysql? ( >=dev-db/mysql-3.23.28 )"

RDEPEND="!virtual/mta >=net-mail/mailbase-0.00 $DEPEND"

TLS_DEP=">=dev-libs/openssl-0.9.6"

#TLS_URI=

#if [ -n "`use mta-tls`" ]; then
#    DEPEND="${DEPEND} ${TLS_DEP}"
#    echo $DEPEND
#fi

PROVIDE="virtual/mta"

src_unpack() {
    unpack ${A}
    cd ${S}/conf
    cp main.cf main.cf.orig
    sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" \
	main.cf.orig > main.cf
    cd ${S}/src/global
    cp mail_params.h mail_params.h.orig
    sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" \
        mail_params.h.orig > mail_params.h
    cd ${S}
    CCARGS="-I/usr/include -DHAS_PCRE"
    AUXLIBS="-L/usr/lib -lpcre"

#    if [ -n "`use mta-tls`" ]; then
#        CCARGS="${CCARGS} -DUSE_SASL_AUTH"
#        AUXLIBS="${AUXLIBS} -lsasl"
#    fi

    if [ -n "`use mta-ldap`" ]; then
        CCARGS="${CCARGS} -DHAS_LDAP"
        AUXLIBS="${AUXLIBS} -lldap -llber"
    fi

    if [ -n "`use mta-mysql`" ]; then
        CCARGS="${CCARGS} -DHAS_MYSQL"
        AUXLIBS="${AUXLIBS} -lmysqlclient -lm"
    fi

    make makefiles CC="cc ${CFLAGS} ${CCARGS} ${AUXLIBS}"
}

src_compile() {
    cd ${S}
    try make
}

src_install () {
    cd ${S}/bin
    insopts -o root -g root -m 0755
    insinto /usr/sbin
    doins post* sendmail

    dodir /usr/bin /usr/sbin /usr/lib
    dosym /usr/sbin/sendmail /usr/bin/mail
    dosym /usr/sbin/sendmail /usr/bin/mailq
    dosym /usr/sbin/sendmail /usr/bin/newaliases
    dosym /usr/sbin/sendmail /usr/lib/sendmail

    cd ${S}/libexec
    dodir /usr/lib/postfix
    insopts -o root -g root -m 0755
    insinto /usr/lib/postfix
    doins *

    cd ${S}
    dodir /etc/postfix
    insopts -o root -g root -m 0644
    insinto /etc/postfix
    doins ${FILESDIR}/main.cf
    doins ${FILESDIR}/master.cf

    cd ${S}/conf
    dodir /etc/postfix/sample
    insopts -o root -g root -m 0644
    insinto /etc/postfix/sample
    doins *.cf access aliases canonical relocated transport \
        pcre_table regexp_table postfix-script*

    insopts -o root -g root -m 0755
    insinto /etc/postfix
    donewins postfix-script-sgid postfix-script

    cd ${S}/man
    for i in man*
    do
        doman $i/*
    done

    cd ${S}
    dodoc *README COMPATIBILITY HISTORY LICENSE PORTING \
        RELEASE_NOTES RESTRICTION_CLASS TODO

    cd ${S}/html
    docinto html
    dodoc *

    dodir /var/spool/postfix
    fperms 0755 /var/spool/postfix
    fowners root.root /var/spool/postfix

    dodir /var/spool/postfix/maildrop
    fperms 1733 /var/spool/postfix/maildrop
    fowners postfix.root /var/spool/postfix/maildrop

    insopts -o root -g root -m 0755
    insinto /etc/rc.d/init.d
    doins ${FILESDIR}/postfix
}

pkg_config() {
    ${ROOT}/usr/sbin/rc-update add postfix
}
