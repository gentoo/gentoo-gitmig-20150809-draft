# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# /home/cvsroot/gentoo-x86/skel.ebuild,v 1.1 2000/10/09 18:00:52 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A highly configurable, drop-in replacement for sendmail"
SRC_URI="ftp://ftp.exim.org/pub/exim/${A}"
HOMEPAGE="http://www.exim.org/"

DEPEND=">=sys-libs/glibc-2.1.3
        >=dev-libs/openssl-0.9.6
        >=sys-devel/perl-5.6.0"

PROVIDE="virtual/mta"

src_compile() {
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
        -e "s:# LOG_FILE_PATH=syslog\:/var/log/exim_%slog:LOG_FILE_PATH=syslog\:/var/log/exim_%slog:" \
        -e "s:# PID_FILE_PATH=/var/lock/exim%s.pid:PID_FILE_PATH=/var/run/exim%s.pid:" \
        -e "s:# SPOOL_DIRECTORY=/var/spool/exim:SPOOL_DIRECTORY=/var/spool/exim:" \
        -e "s:# SUPPORT_PAM=yes:SUPPORT_PAM=yes:" \
        -e "s:# SUPPORT_TLS=yes:SUPPORT_TLS=yes:" \
        -e "s:# TLS_LIBS=-lssl -lcrypto:TLS_LIBS=-lssl -lcrypto:" \
        -e "s:# USE_TCP_WRAPPERS=yes:USE_TCP_WRAPPERS=yes\n\EXTRALIBS=-lpam -lwrap:" src/EDITME > Local/Makefile
    try make
}

src_install () {
    cd ${S}/build-Linux-i386
    insopts -o root -g root -m 4755
    insinto /usr/sbin
    doins exim

    dosym /usr/sbin/exim /usr/sbin/sendmail
    dosym /usr/sbin/exim /usr/sbin/mailq
    dosym /usr/sbin/exim /usr/sbin/newaliases
    dosym /usr/sbin/exim /usr/sbin/mail

    insopts -o root -g root -m 755
    insinto /usr/sbin
    for i in exicyclog exim_dbmbuild exim_dumpdb exim_fixdb \
    exim_lock exim_tidydb exinext exiwhat
    do
      doins $i
    done

    cd ${S}/util
    insopts -o root -g root -m 755
    insinto /usr/sbin
    for i in exigrep eximstats exiqsumm
    do
      doins $i
    done

    cd ${S}/src
    insopts -o root -g root -m 644
    insinto /etc/exim
    donewins configure.default configure

    dodoc ${S}/doc/*

    insopts -m 755
    insinto /etc/rc.d/init.d
    doins ${FILESDIR}/exim
}

pkg_config() {
    ${ROOT}/usr/sbin/rc-update add exim
}
