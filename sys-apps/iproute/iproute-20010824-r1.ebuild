# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute/iproute-20010824-r1.ebuild,v 1.3 2002/09/07 21:43:01 seemant Exp $

S=${WORKDIR}/iproute2
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/iproute2-2.4.7-now-ss010824.tar.gz"
HOMEPAGE=""

SLOT="0"
KEYWORDS="x86 ppc"
DEPEND="virtual/linux-sources"

LICENSE="GPL-2"

pkg_setup() {
	# Make sure kernel headers are really available
	check_KV
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Our patch does two things for us; First, it syncs up with Debian's
	# iproute 20010824-8 package; Secondly, it adds htb3 support.  The Debian
	# patch tweaks the iproute compile so that we use an included pkt_sched.h
	# header rather than looking at the one in /usr/src/linux/include/linux.
	# This allows us to always enable HTB3 without compile problems; however,
	# other parts of the source tree are still dependent upon having a kernel
	# source tree in /usr/src/linux.
	
	patch -p1 < ${FILESDIR}/iproute-debian-8-htb3.diff || die
	
	# why was this commented out? were the programs segfaulting/not working?
	# they seem ok here when i compile with optimisations, so im reenabling
	# this patch. if theres problems, will glady change back. ~woodchip

	cp Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/g" \
	    -e "s/-Werror//g" Makefile.orig > Makefile

	# this next thing is required to enable diffserv (ATM support doesn't compile right now)
	
	cp Config Config.orig
	sed -e 's/DIFFSERV=n/DIFFSERV=y/g' -e 's/ATM=y/ATM=n/g' Config.orig > Config
}

src_compile() {
	emake || die
}

src_install() {
	cd ${S}/ip ; dosbin ifcfg ip routef routel rtacct rtmon rtpr
	cd ${S}/tc ; dosbin tc
	cd ${S} ; dodoc README* RELNOTES

	#install Debian man pages
	doman ${S}/debian/*.[1-9]
	
	docinto examples/diffserv ; dodoc examples/diffserv/*
	docinto examples ; dodoc examples/*
	dodir /etc/iproute2
	insinto /etc/iproute2 ; doins ${S}/etc/iproute2/*
	if [ "`use tetex`" ] ; then
		docinto ps ; dodoc doc/*.ps
	fi
}
