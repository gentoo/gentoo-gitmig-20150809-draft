# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom ryan@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/net-misc/netcat/netcat-110.ebuild,v 1.1 2001/05/18 19:52:37 achim Exp $

A="nc110.tgz"
S=${WORKDIR}/nc-${PV}
DESCRIPTION="A network piping program"
SRC_URI="http://www.l0pht.com/~weld/netcat/${A}"
HOMEPAGE="http://www.l0pht.com/~weld/netcat"

DEPEND="virtual/glibc"

src_unpack() {

    mkdir ${S}
    cd ${S}
    tar zxf ${DISTDIR}/${A}
}

src_compile() {

    cp Makefile Makefile.orig
    cat Makefile.orig | sed -e "s:^CFLAGS =.*$:CFLAGS = ${CFLAGS}:" \
	| sed -e "s:^CC =.*$:CC = gcc \$(CFLAGS):" > Makefile
    cp netcat.c netcat.orig
    cat netcat.orig | sed -e "s:#define HAVE_BIND:#undef HAVE_BIND:" > netcat.c
    try make linux

}

src_install () {

    dobin nc
    dodoc README
    docinto scripts
    dodoc scripts/*

}
