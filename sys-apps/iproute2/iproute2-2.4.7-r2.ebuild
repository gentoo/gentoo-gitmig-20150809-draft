# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.4.7-r2.ebuild,v 1.1 2002/07/30 00:25:47 drobbins Exp $

S=${WORKDIR}/iproute2
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/iproute2-2.4.7-now-ss010824.tar.gz"
HOMEPAGE=""
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

pkg_setup() {
	check_KV
}

src_unpack() {
	unpack ${A}
	cd ${S}
	
	#This adds htb3 support -- drobbins
	patch -p1 < ${FILESDIR}/htb3.6_tc.diff || die
	#This should close bug #595 -- drobbins
	patch -p1 < ${FILESDIR}/dead-route-fix.diff || die
	
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
	sed -e "s/-O2/${CFLAGS}/g" \
	    -e "s/-Werror//g" Makefile.orig > Makefile
	
	# this next thing is required to enable diffserv (ATM support doesn't compile right now)
	# cp Config Config.orig
	# sed -e 's/DIFFSERV=n/DIFFSERV=y/g' Config.orig > Config
	
	#this fix optionally disables the IEEE1394 definition if it is not in the kernel headers
	#This allows this pkg to work with earlier 2.4 kernel headers.
	cp ${FILESDIR}/ll_types.c ${S}/lib
}

src_compile() {
	emake || die
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
