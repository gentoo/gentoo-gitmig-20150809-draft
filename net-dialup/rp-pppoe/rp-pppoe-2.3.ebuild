# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-pppoe/rp-pppoe-2.3.ebuild,v 1.2 2000/11/02 08:31:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A user-mode PPPoE client and server suite for Linux"
SRC_URI="http://www.roaringpenguin.com/pppoe/${A}"
HOMEPAGE="http://www.roaringpeguin.com/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-apps/bash-2.04
	>=net-dialup/ppp-2.4.0"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make RPM_INSTALL_ROOT=${D} install
    gzip ${D}/usr/doc/rp-pppoe-2.3/*
    prepman

}

