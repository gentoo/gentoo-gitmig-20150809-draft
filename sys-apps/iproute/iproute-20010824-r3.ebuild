# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute/iproute-20010824-r3.ebuild,v 1.2 2003/05/27 11:20:18 msterret Exp $

inherit eutils

IUSE="tetex"

S=${WORKDIR}/iproute2
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/iproute2-2.4.7-now-ss010824.tar.gz
	http://ftp.debian.org/debian/pool/main/i/iproute/${P/-/_}-9.diff.gz"
HOMEPAGE="http://www.worldbank.ro/ip-routing/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND="virtual/linux-sources
		>=sys-apps/sed-4"

pkg_setup() {
	# Make sure kernel headers are really available
	check_KV
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Our patch does two things for us; First, it syncs up with Debian's
	# iproute 20010824-9 package; Secondly, it adds htb3 support.  The Debian
	# patch tweaks the iproute compile so that we use an included pkt_sched.h
	# header rather than looking at the one in /usr/src/linux/include/linux.
	# This allows us to always enable HTB3 without compile problems; however,
	# other parts of the source tree are still dependent upon having a kernel
	# source tree in /usr/src/linux.

	epatch ${WORKDIR}/${P/-/_}-9.diff

	# why was this commented out? were the programs segfaulting/not working?
	# they seem ok here when i compile with optimisations, so I'm re-enabling
	# this patch. if there're problems, will gladly change back. ~woodchip

	sed -i \
		-e "s:-O2:${CFLAGS}:g" \
	    -e "s:-Werror::g" Makefile || die "sed Makefile failed"

	# this next thing is required to enable diffserv
	# (ATM support doesn't compile right now)

	sed -i \
		-e 's:DIFFSERV=n:DIFFSERV=y:g' \
		-e 's:ATM=y:ATM=n:g' Config || die "sed Config failed"
}

src_compile() {
	emake || die
}

src_install() {
	into /
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
