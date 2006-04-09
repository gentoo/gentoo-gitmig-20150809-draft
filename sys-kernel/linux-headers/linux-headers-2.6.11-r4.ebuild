# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.11-r4.ebuild,v 1.12 2006/04/09 17:12:49 corsair Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm bfin cris hppa m68k ia64 ppc ppc64 s390 sh sparc x86"
inherit eutils kernel-2
detect_version

PATCHES_V='9'

SRC_URI="${KERNEL_URI} mirror://gentoo/linux-2.6.11-m68k-headers.patch.bz2
	mirror://gentoo/linux-2.6.12.1-blackfin.patch.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-headers/gentoo-headers-${PV}-${PATCHES_V}.tar.bz2"
KEYWORDS="-* alpha ia64 ppc ppc64 sparc" # Do *not* add other archs, this is a revbump-forcer for only #114767 and #115708.

DEPEND="ppc? ( gcc64? ( sys-devel/gcc-powerpc64 ) )
		sparc? ( gcc64? ( sys-devel/gcc-sparc64 ) )"

UNIPATCH_LIST="${DISTDIR}/gentoo-headers-${PV}-${PATCHES_V}.tar.bz2
	${DISTDIR}/linux-2.6.12.1-blackfin.patch.bz2"

kernel-2_hook_premake() {
	# cris is slightly incomplete so lets fake it enough to get headers
	mkdir -p arch/cris/boot
	touch arch/cris/boot/Makefile
}

src_unpack() {
	kernel-2_src_unpack

	# This should always be used but it has a bunch of hunks which
	# apply to include/linux/ which i'm unsure of so only use with
	# m68k for now (dont want to break other arches)
	[[ $(tc-arch) == "m68k" ]] && epatch "${DISTDIR}"/linux-2.6.11-m68k-headers.patch.bz2

	# Fixes ... all the mv magic is to keep sed from dumping
	# ugly warnings about how it can't work on a directory.
	cd "${S}"/include
	mv asm-ia64/sn asm-ppc64/iSeries .
	headers___fix asm-ia64/*
	mv sn asm-ia64/
	headers___fix asm-ppc64/*
	mv iSeries asm-ppc64/
	headers___fix asm-ppc64/iSeries/*
	headers___fix linux/{ethtool,jiffies}.h

	# #114767...
	headers___fix asm-alpha/bitops.h linux/{bitops,wait}.h linux/byteorder/*_endian.h

	# Apply patch for spinlick.h only with 32bit userland on ppc64.
	# Will add to the main patchball when plasmaroo returns.
	if use ppc && [[ ${PROFILE_ARCH} == "ppc64" ]]; then
		epatch ${FILESDIR}/2.6.11-ppc64-32ul-spinlock.patch
	fi
}
