# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/bind/bind-9.1.2.ebuild,v 1.1 2001/05/06 14:31:26 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Name Server"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/${A}"
HOMEPAGE="http://www.isc.org/products/BIND"

DEPEND=">=sys-apps/bash-2.04
        >=sys-devel/libtool-1.3.5
        >=sys-libs/glibc-2.1.3"

#this service should be upgraded to offer optional supervise support

src_unpack() {
	unpack ${A}
	cd ${S}/doc/man
	#fix man pages to reflect Gentoo Linux file locations (drobbins)
	local x
	for x in */*
	do
		cp ${x} ${x}.orig
		sed -e 's:/etc/named.conf:/etc/bind/named.conf:g' -e 's:/etc/rndc.conf:/etc/bind/rndc.conf:g' ${x}.orig > ${x}
		rm ${x}.orig
	done
}

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST} --sysconfdir=/etc/bind --localstatedir=/var --with-libtool
    try make all
}

src_install() {
	dodir /usr/bin
	try make DESTDIR=${D} install
	doman doc/man/*/*.[1-8]
	dodir /etc/rc.d/init.d
	cp ${FILESDIR}/named ${D}/etc/rc.d/init.d
	dodir /etc/bind
	cp ${FILESDIR}/named.conf ${D}/etc/bind/named.conf
	cd ${S}/doc/arm
	dodoc *.html
}

#bind needs config files set up correctly before it should be enabled.
#pkg_config() {
#    . ${ROOT}/etc/rc.d/config/functions
#
#    echo "BIND enabled."
#}
