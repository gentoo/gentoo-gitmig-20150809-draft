# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.22-r1.ebuild,v 1.6 2003/11/20 07:43:38 lostlogic Exp $

ETYPE="sources"
inherit kernel

OKV=${PV/_/-}
CVSDATE=20030825
S=${WORKDIR}/linux-${OKV}
EXTRAVERSION=-mipscvs-${CVSDATE}
KV="${OKV}${EXTRAVERSION}"

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 25 Aug 2003
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS
# 4) patch to fix the SGI wd scsi driver (Broken in CVS)

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
	cat ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff | patch -p1

	# Patch the SGI WD scsi driver so the kernel can boot
	cat ${FILESDIR}/mipscvs-${OKV}-sgiwd-fix.patch | patch -p0

	# Big Endian Fix (Fixed in 2.4.23)
	cat ${FILESDIR}/bigendian-byteorder-fix.patch | patch -p1

	# Patch arch/mips/Makefile for gcc
	cat ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch | patch -p0

	kernel_universal_unpack
}
