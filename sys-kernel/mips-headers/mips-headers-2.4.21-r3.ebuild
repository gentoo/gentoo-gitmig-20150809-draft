# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-headers/mips-headers-2.4.21-r3.ebuild,v 1.1 2003/10/16 03:53:45 kumba Exp $


ETYPE="headers"
inherit kernel eutils
OKV=${PV/_/-}
CVSDATE=20030803
S=${WORKDIR}/linux-${OKV}
EXTRAVERSION=-mipscvs-${CVSDATE}
PROVIDE="virtual/os-headers"


# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 03 Aug 2003
# 3) patch to fix arch/mips/Makefile to pass appropriate CFLAGS


DESCRIPTION="Linux-Mips CVS headers for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2"
HOMEPAGE="http://www.linux-mips.org/"
KEYWORDS="-* mips"
SLOT="${OKV}"

src_unpack() {
	unpack ${A}
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
