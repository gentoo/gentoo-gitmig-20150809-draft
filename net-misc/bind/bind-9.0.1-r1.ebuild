# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/bind/bind-9.0.1-r1.ebuild,v 1.1 2000/12/20 20:50:02 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Name Server"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/"${A}
HOMEPAGE="http://www.isc.org/products/BIND"

DEPEND=">=sys-apps/bash-2.04
        >=sys-devel/libtool-1.3.5
        >=sys-libs/glibc-2.1.3"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST} \
        --sysconfdir=/etc/bind --localstatedir=/var --with-libtool
    try make all
}


src_install() {
    dodir /usr/bin
    try make DESTDIR=${D} install

	doman doc/man/*/*.[1-8]

	dodir /etc/rc.d/init.d
	cp ${O}/files/named ${D}/etc/rc.d/init.d
	cp ${O}/files/named.conf ${D}/etc/bind/named.conf
}

pkg_config() {
    . ${ROOT}/etc/rc.d/config/functions

    echo "BIND enabled."
}
