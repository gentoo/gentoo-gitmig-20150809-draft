# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.4.7.ebuild,v 1.2 2001/10/01 22:35:24 drobbins Exp $

A=iproute2-2.4.7-now-ss010824.tar.gz
S=${WORKDIR}/iproute2
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/${A}"

DEPEND="virtual/glibc"
# if we include tex, it _could_ lead to X being pulled in during emerge system.
# tex? ( app-text/tetex )"

src_unpack() {

    unpack ${A}

    # we now install the kernel headers used for compiling glibc, directly into
    # /usr/include/{asm,linux}; which is a good thing(tm). we need to patch
    # iproute2's Makefile to thusly compile without a /usr/src/linux tree.
    # ~woodchip
    cd ${S}
    patch -p0 < ${FILESDIR}/makefile-kernel-includes.diff || die

    # omits this protocol support from being built:  "__PF(PUP,pup)"
    # the package builds fine without this patch. is there another concern?
    # ~woodchip
    # cd ${S}/lib
    # cp ll_proto.c ll_proto.c.orig
    # sed -e "36 d" ll_proto.c.orig > ll_proto.c

    # why was this commented out? were the programs segfaulting/not working?
    # they seem ok here when i compile with optimisations, so im reenabling
    # this patch. if theres problems, will glady change back. ~woodchip
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/g" Makefile.orig > Makefile

    # this next thing is required to enable diffserv (ATM support doesn't compile right now)
    # cp Config Config.orig
    # sed -e 's/DIFFSERV=n/DIFFSERV=y/g' Config.orig > Config

	#this fix optionally disables the IEEE1394 definition if it is not in the kernel headers
	#This allows this pkg to work with earlier 2.4 kernel headers.
	cp ${FILESDIR}/ll_types.c ${S}/lib
}

src_compile() {

    make ${MAKEOPTS} || die
    # if [ "`use tex`" ] ; then
    #     cd doc
    #     make || die
    # fi
}

src_install() {

    cd ${S}/ip ; dosbin ifcfg ip routef routel rtacct rtmon rtpr
    cd ${S}/tc ; dosbin tc

    cd ${S} ; dodoc README* RELNOTES
    docinto examples/diffserv ; dodoc examples/diffserv/*
    docinto examples ; dodoc examples/*

    dodir /etc/iproute2
    insinto /etc/iproute2 ; doins ${S}/etc/iproute2/*

    if [ "`use tex`" ] ; then
        docinto ps ; dodoc doc/*.ps
    fi
}
