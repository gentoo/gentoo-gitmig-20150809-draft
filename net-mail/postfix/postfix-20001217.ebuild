# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/postfix/postfix-20001217.ebuild,v 1.1 2000/12/20 21:03:08 jerry Exp $

P=snapshot-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A fast and secure drop-in replacement for sendmail"
SRC_URI="ftp://ftp.porcupine.org/mirrors/postfix-release/experimental/${A}"
HOMEPAGE="http://www.postfix.org/"

DEPEND=">=sys-libs/glibc-2.1.3"

PROVIDE="virtual/mta"

src_compile() {
    cd ${S}
    make makefiles CC="cc ${CFLAGS}"
    try make
}

src_install () {
    cd ${S}/bin
    insopts -o root -g root -m 755
    insinto /usr/sbin
    doins post* sendmail

    dodir /usr/bin /usr/sbin /usr/lib
    dosym /usr/sbin/sendmail /usr/bin/mail
    dosym /usr/sbin/sendmail /usr/bin/mailq
    dosym /usr/sbin/sendmail /usr/bin/newaliases
    dosym /usr/sbin/sendmail /usr/lib/sendmail

    cd ${S}/libexec
    dodir /usr/libexec/postfix
    insopts -o root -g root -m 755
    insinto /usr/libexec/postfix
    doins *

    cd ${S}/conf
    dodir /etc/postfix
    insopts -o root -g root -m 644
    insinto /etc/postfix
    doins *
    fperms 755 /etc/postfix/postfix-script*

    cd ${S}/man
    for i in man*
    do
        doman $i/*
    done

    cd ${S}
    dodoc *README BEWARE COMPATIBILITY HISTORY LICENSE PORTING \
        RELEASE_NOTES RESTRICTION_CLASS TODO

    cd ${S}/html
    docinto html
    dodoc *

    dodir /var/spool/postfix
    fperms 755 /var/spool/postfix
    fowners postfix.root /var/spool/postfix

    dodir /var/spool/postfix/maildrop
    fperms 1733 /var/spool/postfix/maildrop
    fowners postfix.root /var/spool/postfix/maildrop

    insopts -m 755
    insinto /etc/rc.d/init.d
    doins ${FILESDIR}/postfix
}

pkg_config() {
    ${ROOT}/usr/sbin/rc-update add postfix
}
