# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute/iproute-20010824-r4.ebuild,v 1.8 2004/01/09 00:42:39 gmsoft Exp $

inherit eutils

IUSE="tetex"

DEBIANPATCH="${P/-/_}-11.diff.gz"
SRCFILE="iproute2-2.4.7-now-ss${PV/20}.tar.gz"

S=${WORKDIR}/iproute2
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/${SRCFILE}
	http://ftp.debian.org/debian/pool/main/i/iproute/${DEBIANPATCH}"
HOMEPAGE="http://www.worldbank.ro/ip-routing/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ppc sparc ~alpha hppa ~mips"

# we install our kernel headers in /usr/include/linux
# we should NEVER depend on /usr/src/linux existing ever
# ~robbat2 2003/08/16
DEPEND="virtual/os-headers
		>=sys-apps/sed-4
		tetex? ( app-text/tetex )"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${SRCFILE}
	cd ${S}

	# Our patch does two things for us; First, it syncs up with Debian's
	# iproute 20010824-9 package; Secondly, it adds htb3 support.  The Debian
	# patch tweaks the iproute compile so that we use an included pkt_sched.h
	# header rather than looking at the one in /usr/src/linux/include/linux.
	# This allows us to always enable HTB3 without compile problems; 

	epatch ${DISTDIR}/${DEBIANPATCH}

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
	emake KERNEL_INCLUDE=/usr/include || die
}

src_install() {
	into /
	cd ${S}/ip ; dosbin ifcfg ip routef routel rtacct rtmon rtpr
	cd ${S}/tc ; dosbin tc
	cd ${S} ; dodoc README* RELNOTES

	#install Debian man pages
	doman ${S}/debian/manpages/*.[1-9]

	docinto examples/diffserv ; dodoc examples/diffserv/*
	docinto examples ; dodoc examples/*
	dodir /etc/iproute2
	insinto /etc/iproute2 ; doins ${S}/etc/iproute2/*
	if use tetex && [ -n "`ls doc/*.ps`" ] ; then
		docinto ps ; dodoc doc/*.ps
	fi
}
