# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.21-r3.ebuild,v 1.1 2004/01/06 01:53:15 kumba Exp $

ETYPE="sources"
inherit kernel

OKV=${PV/_/-}
CVSDATE=20030803
S=${WORKDIR}/linux-${OKV}
EXTRAVERSION=-mipscvs-${CVSDATE}
KV="${OKV}${EXTRAVERSION}"

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 03 Aug 2003
# 3) patch to fix arch/mips/Makefile to pass appropriate CFLAGS

DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2"
HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* mips"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Patch arch/mips/Makefile for gcc (Pass -mips3/-mips4 for r4k/r5k cpus)
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch

	# Big Endian Fix (Fix in headers for big-endian machines)
	epatch ${FILESDIR}/bigendian-byteorder-fix.patch

	# do_brk fix (Fixes exploit that hit several debian servers)
	epatch ${FILESDIR}/do_brk_fix.patch

	# mremap fix (Possibly Exploitable)
	epatch ${FILESDIR}/mremap-fix.patch

	# MIPS RTC Fixes (Fixes memleaks, backport from 2.4.24)
	epatch ${FILESDIR}/rtc-fixes.patch

	kernel_universal_unpack
}
