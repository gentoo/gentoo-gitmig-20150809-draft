# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-headers/mips-headers-2.4.21-r3.ebuild,v 1.6 2004/02/06 18:18:27 iggy Exp $

ETYPE="headers"
inherit kernel

OKV=${PV/_/-}
CVSDATE=20030803
EXTRAVERSION=-mipscvs-${CVSDATE}
KV="${OKV}${EXTRAVERSION}"
S=${WORKDIR}/linux-${KV}

inherit eutils

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 03 Aug 2003
# 3) patch to fix arch/mips/Makefile to pass appropriate CFLAGS


DESCRIPTION="Linux-Mips CVS headers for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2"
HOMEPAGE="http://www.linux-mips.org/"
SLOT="0"
PROVIDE="virtual/os-headers"
KEYWORDS="-* mips"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${S}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Big Endian Fix
	epatch ${FILESDIR}/bigendian-byteorder-fix.patch

	kernel_universal_unpack
}

src_install() {

	# Do normal src_install stuff
	kernel_src_install

	# If this is mips64, then we need asm-mips64 stuff too
	if [ "${PROFILE_ARCH}" = "mips64" ]; then
		dodir /usr/include/asm-mips64
		cp -ax ${S}/include/asm-mips64/* ${D}/usr/include/asm-mips64
	fi
}
