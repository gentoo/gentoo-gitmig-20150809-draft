# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.2.4-r2.ebuild,v 1.2 2001/05/02 16:14:25 achim Exp $

A=iproute2-2.2.4-now-ss001007.tar.gz
S=${WORKDIR}/iproute2
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/${A}"

DEPEND="virtual/glibc tex? ( app-text/tetex )"

src_unpack() {
    unpack ${A}
    cd ${S}
#    cp Makefile Makefile.orig
#    sed -e "s/-O2/${CFLAGS}/g" Makefile.orig > Makefile
#	#this next thing is required to enable diffserv (ATM support doesn't compile right now)
#	cp Config Config.orig
#	sed -e 's/DIFFSERV=n/DIFFSERV=y/g' Config.orig > Config
}

src_compile() {
    try make ${MAKEOPTS}
    if [ "`use tex`" ]
    then
		cd doc
		try make
    fi
}


src_install() {

	into /
   	cd ${S}/ip
	dosbin ifcfg ip routef routel rtacct rtmon rtpr
	cd ${S}/tc
	dosbin tc
	cd ${S}
	dodoc README* RELNOTES
	docinto examples/diffserv
	dodoc examples/diffserv/*
	docinto examples
	dodoc examples/*
	dodir /etc/iproute2
	insinto /etc/iproute2
	doins ${S}/etc/iproute2/*

	if [ "`use tex`" ]
	then
	    docinto ps
	    dodoc doc/*.ps
	fi

}


