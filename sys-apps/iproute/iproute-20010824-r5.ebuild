# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute/iproute-20010824-r5.ebuild,v 1.6 2004/04/07 04:02:49 vapier Exp $

inherit eutils flag-o-matic

DEBIANPATCH="${P/-/_}-13.diff.gz"
SRCFILE="iproute2-2.4.7-now-ss${PV/20}.tar.gz"

DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://www.worldbank.ro/ip-routing/"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/${SRCFILE}
	mirror://debian/pool/main/i/iproute/${DEBIANPATCH}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips ~alpha hppa ~amd64"
IUSE="doc"

DEPEND="virtual/os-headers
	>=sys-apps/sed-4
	doc? ( virtual/tetex )"
RDEPEND="virtual/glibc"

S=${WORKDIR}/iproute2

src_unpack() {
	unpack ${SRCFILE}
	cd ${S}

	# Our patch does two things for us; First, it syncs up with Debian's
	# iproute 20010824-9 package; Secondly, it adds htb3 support.  The Debian
	# patch tweaks the iproute compile so that we use an included pkt_sched.h
	# header rather than looking at the one in /usr/src/linux/include/linux.
	# This allows us to always enable HTB3 without compile problems; 
	epatch ${DISTDIR}/${DEBIANPATCH}

	# Enable HFSC scheduler #45274
	if [ ! -z "`grep tc_service_curve ${ROOT}/usr/include/linux/pkt_sched.h`" ] ; then
		epatch ${FILESDIR}/${PV}-hfsc.patch
	else
		ewarn "Your linux-headers in /usr/include/linux are too old to"
		ewarn "support the HFSC scheduler.  It has been disabled."
	fi
	epatch ${FILESDIR}/${PV}-rates-1024-fix.patch
	rm include/linux/pkt_sched.h

	# Now a little hack to handle 2.4.x headers and stupid defines ...
	if has_version '<sys-kernel/linux-headers-2.6' ; then
		echo '#define __constant_htons(x) htons(x)' >> include-glibc/glibc-bugs.h
		append-flags -D_LINUX_BYTEORDER_LITTLE_ENDIAN_H -D_LINUX_BYTEORDER_BIG_ENDIAN_H
	fi

	# Fix local DoS exploit #34294
	epatch ${FILESDIR}/${PV}-local-exploit-fix.patch

	sed -i \
		-e "s:-O2:${CFLAGS}:g" \
	    -e "s:-Werror::g" \
		-e "s:-I../include-glibc::g" \
		Makefile || die "sed Makefile failed"

	# this next thing is required to enable diffserv
	# (ATM support doesn't compile right now)
	sed -i \
		-e 's:DIFFSERV=n:DIFFSERV=y:g' \
		-e 's:ATM=y:ATM=n:g' \
		Config || die "sed Config failed"
}

src_compile() {
	emake KERNEL_INCLUDE=/usr/include || die
}

src_install() {
	into /
	cd ${S}/ip
	dosbin ifcfg ip routef routel rtacct rtmon rtpr || die "dosbin * failed"
	cd ${S}/tc
	dosbin tc || die "dosbin tc failed"
	cd ${S}

	doman debian/manpages/*.[1-9]

	dodoc README* RELNOTES
	docinto examples ; dodoc examples/*
	docinto examples/diffserv ; dodoc examples/diffserv/*
	dodir /etc/iproute2
	insinto /etc/iproute2 ; doins ${S}/etc/iproute2/*
	if use doc && [ -n "`ls doc/*.ps`" ] ; then
		docinto ps ; dodoc doc/*.ps
	fi
}
