# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gaming-sources/gaming-sources-2.4.20-r7.ebuild,v 1.3 2004/01/24 19:22:55 plasmaroo Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  

ETYPE="sources"

inherit kernel

OKV="2.4.20"
EXTRAVERSION="-gaming-r7"
KV="${OKV}${EXTRAVERSION}"
S=${WORKDIR}/linux-${KV}
CKV="2.4.20-ck7"

DESCRIPTION="Full sources for the Gentoo gaming-optimized kernel"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 mirror://gentoo/patches-${KV/7/5}.tar.bz2 http://www.plumlocosoft.com/kernel/patches/2.4/${OKV}/linux-${CKV}.patch.bz2"

KEYWORDS="x86"
SLOT="${KV}"

src_unpack() {

	unpack linux-${OKV}.tar.bz2 patches-${KV/7/5}.tar.bz2
	bzcat ${DISTDIR}/linux-${CKV}.patch.bz2 | patch -p0 || die "-ck patch failed"

	mv linux-${OKV} linux-${KV} || die

	cd ${KV/7/5} || die
	rm 98_nforce2_agp.patch # In -ck7
	kernel_src_unpack

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${P}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${P}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"

}
