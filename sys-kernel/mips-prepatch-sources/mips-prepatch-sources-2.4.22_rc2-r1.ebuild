# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-prepatch-sources/mips-prepatch-sources-2.4.22_rc2-r1.ebuild,v 1.2 2003/09/07 07:26:01 msterret Exp $


# Eclass Stuff
ETYPE="sources"
inherit kernel

# Version Data
OKV=${PV/_/-}
CVSDATE=20030813
EXTRAVERSION=-$(echo ${OKV} | cut -d- -f2)-mipscvs-${CVSDATE}
STABLEVERSION=2.4.21

# Miscellaneous
S=${WORKDIR}/linux-${OKV}
PROVIDE="virtual/linux-sources"


# INCLUDED:
# 1) linux stable sources from kernel.org
# 2) patch to latest linux prepatch sources
# 3) linux-mips.org CVS snapshot diff from 13 Aug 2003
# 4) patch to fix arch/mips/Makefile to pass appropriate CFLAGS

DESCRIPTION="Linux-Mips CVS pre-patch sources for MIPS-based machines"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${STABLEVERSION}.tar.bz2
		mirror://kernel/linux/kernel/v2.4/testing/patch-${OKV}.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2"
HOMEPAGE="http://www.kernel.org   http://www.linux-mips.org/"
KEYWORDS="-* ~mips"
SLOT="${OKV}"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${STABLEVERSION} ${S}
	cd ${S}

	# Update the vanilla sources with prepatch diff
	einfo ">>> Patching linux-${STABLEVERSION} to linux-${OKV} ..."
	cat ${WORKDIR}/patch-${OKV} | patch -p1

	# Update the vanilla prepatch sources with linux-mips CVS changes
	einfo ">>> Patching linux-${OKV} to linux-${OKV}${EXTRAVERSION} ..."
	cat ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff | patch -p1

	# Patch arch/mips/Makefile for gcc
	einfo ">>> Patching arch/mips/Makefile ..."
	cat ${FILESDIR}/mips-gcc-makefile-fix-${CVSDATE}.patch | patch -p0

	kernel_universal_unpack
}
