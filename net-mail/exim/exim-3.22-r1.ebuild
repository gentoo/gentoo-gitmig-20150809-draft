# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# /home/cvsroot/gentoo-x86/skel.ebuild,v 1.1 2000/10/09 18:00:52 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A highly configurable, drop-in replacement for sendmail"
SRC_URI="ftp://ftp.exim.org/pub/exim/${A}"
HOMEPAGE="http://www.exim.org/"

DEPEND=">=net-mail/mailbase-0.00
        >=sys-libs/glibc-2.1.3
        >=sys-devel/perl-5.6.0"

RDEPEND="!virtual/mta"

TLS_DEP=">=dev-libs/openssl-0.9.6"
LDAP_DEP=">=net-nds/openldap-2.0.7"
MYSQL_DEP=">=dev-db/mysql-3.23.28"

if [ -n "`use mta-tls`" ]; then
    DEPEND="${DEPEND} ${TLS_DEP}"
fi

if [ -n "`use mta-ldap`" ]; then
    DEPEND="${DEPEND} ${LDAP_DEP}"
fi

if [ -n "`use mta-mysql`" ]; then
    DEPEND="${DEPEND} ${MYSQL_DEP}"
fi

PROVIDE="virtual/mta"

src_unpack() {
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
        -e "s:# LOG_FILE_PATH=syslog:LOG_FILE_PATH=syslog:" \
        -e "s:# PID_FILE_PATH=/var/lock/exim%s.pid:PID_FILE_PATH=/var/run/exim%s.pid:" \
        -e "s:# SPOOL_DIRECTORY=/var/spool/exim:SPOOL_DIRECTORY=/var/spool/exim:" \
        -e "s:# SUPPORT_MAILDIR=yes:SUPPORT_MAILDIR=yes:" \
        -e "s:# SUPPORT_PAM=yes:SUPPORT_PAM=yes:" \
        -e "s:# USE_TCP_WRAPPERS=yes:USE_TCP_WRAPPERS=yes\n\EXTRALIBS=-lpam -lwrap:" src/EDITME > Local/Makefile
    try make

    if [ -n "`use mta-tls`" ]; then
        cp Local/Makefile Local/Makefile.tmp
        sed -e "s:# SUPPORT_TLS=yes:SUPPORT_TLS=yes:" \
            -e "s:# TLS_LIBS=-lssl -lcrypto:TLS_LIBS=-lssl -lcrypto:" Local/Makefile.tmp > Local/Makefile
    fi

    if [ -n "`use mta-ldap`" ]; then
        cp Local/Makefile Local/Makefile.tmp
        sed -e "s:# LOOKUP_LDAP=yes:LOOKUP_LDAP=yes:" \
            -e "s:# LOOKUP_INCLUDE=-I /usr/local/ldap/include -I /usr/local/mysql/include -I /usr/local/pgsql/include:LOOKUP_INCLUDE=-I/usr/include/ldap -I/usr/include/mysql:" \
            -e "s:# LOOKUP_LIBS=-L/usr/local/lib -lldap -llber -lmysqlclient -lpq:LOOKUP_LIBS=-L/usr/lib -lldap -llber -lmysqlclient -lpq:" \
            -e "s:# LDAP_LIB_TYPE=OPENLDAP2:LDAP_LIB_TYPE=OPENLDAP2:" Local/Makefile.tmp >| Local/Makefile
    fi

    if [ -n "`use mta-mysql`" ]; then
        cp Local/Makefile Local/Makefile.tmp
        sed -e "s:# LOOKUP_MYSQL=yes:LOOKUP_MYSQL=yes:" \
            -e "s:# LOOKUP_LIBS=-L/usr/local/lib -lldap -llber -lmysqlclient -lpq:LOOKUP_LIBS=-L/usr/lib -lldap -llber -lmysqlclient -lpq:" Local/Makefile.tmp >| Local/Makefile
    fi
}

src_compile() {
    cd ${S}
    try make
}

src_install () {
    cd ${S}/build-Linux-i386
    insopts -o root -g root -m 4755
    insinto /usr/sbin
    doins exim

    dodir /usr/bin /usr/sbin /usr/lib
    dosym /usr/sbin/exim /usr/bin/mailq
    dosym /usr/sbin/exim /usr/bin/newaliases
    dosym /usr/sbin/exim /usr/bin/mail
    dosym /usr/sbin/exim /usr/lib/sendmail
    dosym /usr/sbin/exim /usr/sbin/sendmail

    insopts -o root -g root -m 0755
    insinto /usr/sbin
    for i in exicyclog exim_dbmbuild exim_dumpdb exim_fixdb \
    exim_lock exim_tidydb exinext exiwhat
    do
      doins $i
    done

    cd ${S}/util
    insopts -o root -g root -m 0755
    insinto /usr/sbin
    for i in exigrep eximstats exiqsumm
    do
      doins $i
    done

    dodir /etc/exim /etc/exim/samples

    insopts -o root -g root -m 0644
    insinto /etc/exim
    doins ${FILESDIR}/configure

    cd ${S}/src
    insopts -o root -g root -m 0644
    insinto /etc/exim/samples
    doins configure.default

    insopts -o root -g root -m 0755
    insinto /etc/rc.d/init.d
    doins ${FILESDIR}/exim

    dodoc ${S}/doc/*
}

pkg_config() {
    ${ROOT}/usr/sbin/rc-update add exim
}
