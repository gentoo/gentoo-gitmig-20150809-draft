# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.4.7.20020116.ebuild,v 1.11 2004/08/04 05:01:52 vapier Exp $

inherit eutils flag-o-matic

# Deb patches have been stripped/updated from the 13 deb release
SRCFILE="iproute2-2.4.7-now-ss020116-try.tar.gz"
DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://www.worldbank.ro/ip-routing/"
SRC_URI="http://ftp.iasi.roedu.net/mirrors/ftp.inr.ac.ru/ip-routing/${SRCFILE}
	ftp://ftp.inr.ac.ru/ip-routing/${SRCFILE}
	mirror://gentoo/${P}-manpages.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64"
IUSE="atm doc"

RDEPEND="virtual/libc
	=sys-libs/db-1*
	atm? ( net-dialup/linux-atm )"
DEPEND="${RDEPEND}
	>=virtual/os-headers-2.4.21
	>=sys-apps/sed-4
	doc? ( virtual/tetex )"

S=${WORKDIR}/iproute2

src_unpack() {
	unpack ${SRCFILE}
	cd ${S}

	# Enable HFSC scheduler #45274
	if [ ! -z "`grep tc_service_curve ${ROOT}/usr/include/linux/pkt_sched.h`" ] ; then
		epatch ${FILESDIR}/${PV}-hfsc.patch
	else
		ewarn "Your linux-headers in /usr/include/linux are too old to"
		ewarn "support the HFSC scheduler.  It has been disabled."
	fi

	# Enable HTB scheduler (stripped from debian patch)
	epatch ${FILESDIR}/${PV}-htb.patch
	# Add a few debian fixes
	epatch ${FILESDIR}/${PV}-misc-deb-fixes.patch
	# Add manpages from debian
	epatch ${DISTDIR}/${P}-manpages.patch.bz2

	# Make sure we use glibc tcp.h instead of kernel tcp.h
	sed -i '/include/s:linux/tcp\.h:netinet/tcp.h:' misc/ss.c || die "sed ss.c failed"

	# Now a little hack to handle kernel headers and stupid defines ...
	echo '#define __constant_htons(x) htons(x)' >> include-glibc/glibc-bugs.h
	append-flags -D_LINUX_BYTEORDER_LITTLE_ENDIAN_H -D_LINUX_BYTEORDER_BIG_ENDIAN_H

	# Fix local DoS exploit #34294
	epatch ${FILESDIR}/${PV}-local-exploit-fix.patch

	# Fix db and glibc includes
	sed -i \
		-e "s:-O2:${CFLAGS}:g" \
		-e 's:-I\.\./include-glibc::g' \
		-e 's:db3:db1:g' \
		Makefile || die "sed Makefile failed"
	sed -i 's:-ldb:-ldb1:' misc/Makefile || die "sed misc/Makefile failed"

	# Enable diffserv/atm support
	if use atm ; then
		sed -i 's:=n$:=y:' Config || die "sed Config failed"
	fi
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

	doman debian/manpages/*

	dodoc README* RELNOTES
	docinto examples ; dodoc examples/*
	docinto examples/diffserv ; dodoc examples/diffserv/*
	dodir /etc/iproute2
	insinto /etc/iproute2 ; doins ${S}/etc/iproute2/*
	if use doc && [ -n "`ls doc/*.ps`" ] ; then
		docinto ps ; dodoc doc/*.ps
	fi
}
