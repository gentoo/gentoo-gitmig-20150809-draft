# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.2.4.ebuild,v 1.1 2000/11/05 02:52:16 drobbins Exp $

A=iproute2-2.2.4-now-ss001007.tar.gz
S=${WORKDIR}/iproute2
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/${A}"

src_compile() {                           
    try make
}

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/g" Makefile.orig > Makefile
}

src_install() {                               
    into /
	cd ${S}/ip
	dosbin ifcfg ip routef routel rtacct rtmon rtpr
	cd ${S}/tc
	dosbin tc
	cd ${S}
	dodoc README* RELNOTES examples/*
	dodir /etc/iproute2
	insinto /etc/iproute2
	doins ${S}/etc/iproute2/*
}


