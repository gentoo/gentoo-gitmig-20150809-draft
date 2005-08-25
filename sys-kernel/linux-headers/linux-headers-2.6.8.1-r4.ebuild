# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.8.1-r4.ebuild,v 1.8 2005/08/25 13:26:19 gustavoz Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm hppa ia64 ppc ppc64 s390 sparc sh x86"
inherit kernel-2
detect_version

PATCHES_V='2'

SRC_URI="${KERNEL_URI} mirror://gentoo/linux-2.6.8.1-sh-headers.patch.bz2
	 http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-headers/gentoo-headers-${PV}-${PATCHES_V}.tar.bz2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~s390 ~sparc sh x86"

DEPEND="ppc? ( gcc64? ( sys-devel/gcc-powerpc64 ) )
		sparc? ( gcc64? ( sys-devel/gcc-sparc64 ) )"

UNIPATCH_LIST="${DISTDIR}/linux-2.6.8.1-sh-headers.patch.bz2
	${DISTDIR}/gentoo-headers-${PV}-${PATCHES_V}.tar.bz2"

src_unpack() {
	kernel-2_src_unpack

	# Fixes ... all the mv magic is to keep sed from dumping 
	# ugly warnings about how it can't work on a directory.
	cd "${S}"/include
	mv asm-ia64/sn asm-ppc64/iSeries .
	headers___fix asm-ia64/*
	mv sn asm-ia64/
	headers___fix asm-ppc64/*
	mv iSeries asm-ppc64/
	headers___fix asm-ppc64/iSeries/*
	headers___fix linux/ethtool.h
}
