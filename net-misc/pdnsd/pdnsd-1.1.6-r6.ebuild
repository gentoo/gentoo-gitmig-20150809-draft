# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry A! <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/pdnsd/pdnsd-1.1.6-r6.ebuild,v 1.1 2001/09/11 08:42:23 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Proxy DNS server with permanent caching"
SRC_URI="http://home.t-online.de/home/Moestl/${P}.tar.bz2"
HOMEPAGE="http://home.t-online.de/home/Moestl/"

DEPEND="virtual/glibc"

src_compile() {                           
    ./configure --prefix=/usr --host=${CHOST} \
        --sysconfdir=/etc/pdnsd --with-cachedir=/var/lib/pdnsd || die
    make all || die
}

src_install() {
    make DESTDIR=${D} install || die

    rm -rf ${D}/usr/man
    doman doc/pdnsd-ctl.8

    dodoc AUTHORS COPYING* ChangeLog* NEWS README THANKS TODO
    newdoc doc/pdnsd.conf pdnsd.conf.sample
    cd ${S}/contrib
    docinto contrib ; dodoc README dhcp2pdnsd pdnsd_dhcp.pl
    cd ${S}/doc
    docinto html ; dodoc html/*
    docinto txt ; dodoc txt/*

    exeinto /etc/init.d
    newexe ${FILESDIR}/pdnsd.rc6 pdnsd
}
