# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.23-r1.ebuild,v 1.1 2003/12/15 05:20:25 kumba Exp $

ETYPE="sources"
inherit kernel

OKV=${PV/_/-}
CVSDATE=20031214
S=${WORKDIR}/linux-${OKV}-${CVSDATE}
EXTRAVERSION=-mipscvs-${CVSDATE}
KV="${OKV}${EXTRAVERSION}"

inherit eutils

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 28 Nov 2003
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS and 
#    tweaks arch/mips64/Makefile to pass -Wa,-mabi=o64 instead of -Wa,-32
# 4) SGI XFS patches for 2.4.23


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		ftp://oss.sgi.com/projects/xfs/patches/${OKV}/xfs-${OKV}-split-only.bz2
		ftp://oss.sgi.com/projects/xfs/patches/${OKV}/xfs-${OKV}-split-kernel.bz2
		ftp://oss.sgi.com/projects/xfs/patches/${OKV}/xfs-${OKV}-split-acl.bz2"
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

	# Patch arch/mips/Makefile for gcc
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch

	# Patch in XFS Support
	ebegin "Applying XFS Patches"
	cat ${WORKDIR}/xfs-${OKV}-split-only | patch -p1 2>&1 >/dev/null
	cat ${WORKDIR}/xfs-${OKV}-split-kernel | patch -p1 2>&1 >/dev/null
	cat ${WORKDIR}/xfs-${OKV}-split-acl | patch -p1 2>&1 >/dev/null
	eend

	kernel_universal_unpack
}
