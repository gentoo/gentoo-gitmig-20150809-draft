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

src_compile() {
    cd ${S}
    mkdir Local
    cp ${FILESDIR}/Makefile Local
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
