# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-headers/mips-headers-2.4.21-r1.ebuild,v 1.9 2004/02/06 18:18:27 iggy Exp $

ETYPE="headers"
inherit kernel

OKV=${PV/_/-}
CVSDATE=20030705
EXTRAVERSION=-mipscvs-${CVSDATE}
KV="${OKV}${EXTRAVERSION}"
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
# 1) linux-mips.org CVS snapshot from 05 Jul 2003
# 2) patch off linux-mips ML to fix r4k cache handling
# 3) patch to fix arch/mips/Makefile to pass appropriate CFLAGS

DESCRIPTION="Linux-Mips CVS headers for MIPS-based machines"
SRC_URI="mirror://gentoo/linux-mips-${OKV}-${CVSDATE}.tar.bz2
		mirror://gentoo/mips-patches-${OKV}-${CVSDATE}.tar.bz2"
HOMEPAGE="http://www.linux-mips.org/"
SLOT="0"
PROVIDE="virtual/os-headers"
KEYWORDS="-* mips"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${S}
	cd ${S}

	# Fix R4K Cache Handling
	cat ${WORKDIR}/mips-patches-r4k-cache-fix.patch | patch -p1

	# Determine the gcc version and patch arch/mips/Makefile appropriately
	GCCVER=$(gcc -dumpversion | cut -d. -f1,2)
	case ${GCCVER} in
		3.2) cat ${WORKDIR}/mips-patches-gcc32-makefile-fix.patch | patch -p0;;
		3.3) cat ${WORKDIR}/mips-patches-gcc33-makefile-fix.patch | patch -p0;;
	esac


	kernel_universal_unpack
}
