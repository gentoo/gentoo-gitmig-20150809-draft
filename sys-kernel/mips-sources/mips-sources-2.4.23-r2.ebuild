# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.23-r2.ebuild,v 1.1 2004/01/06 01:53:15 kumba Exp $

ETYPE="sources"
inherit kernel

OKV=${PV/_/-}
CVSDATE=20031128
S=${WORKDIR}/linux-${OKV}-${CVSDATE}
EXTRAVERSION=-mipscvs-${CVSDATE}
KV="${OKV}${EXTRAVERSION}"

inherit eutils

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 28 Nov 2003
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS and 
#	tweaks arch/mips64/Makefile to pass -Wa,-mabi=o64 instead of -Wa,-32
# 4) XFS Patches for basic XFS support (with ACL, but no DMAPI)

DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		ftp://oss.sgi.com/projects/xfs/patches/2.4.23/xfs-2.4.23-split-only.bz2
		ftp://oss.sgi.com/projects/xfs/patches/2.4.23/xfs-2.4.23-split-kernel.bz2
		ftp://oss.sgi.com/projects/xfs/patches/2.4.23/xfs-2.4.23-split-acl.bz2"
HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* ~mips"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Patch arch/mips/Makefile for gcc (Pass -mips3/-mips4 for r4k/r5k cpus)
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch

	# mremap fix (Possibly Exploitable)
	epatch ${FILESDIR}/mremap-fix.patch

	# MIPS RTC Fixes (Fixes memleaks, backport from 2.4.24)
	epatch ${FILESDIR}/rtc-fixes.patch

	# XFS Patches
	# We don't use epatch here because something funny is messed up in the XFS patches,
	# thus while they apply, they don't apply properly
	ebegin "Applying XFS Patchset"
	cat ${WORKDIR}/xfs-${PV}-split-only | patch -p1 2>&1 >/dev/null
	cat ${WORKDIR}/xfs-${PV}-split-kernel | patch -p1 2>&1 >/dev/null
	cat ${WORKDIR}/xfs-${PV}-split-acl | patch -p1 2>&1 >/dev/null
	eend

	kernel_universal_unpack
}
