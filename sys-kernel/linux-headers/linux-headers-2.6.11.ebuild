# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.11.ebuild,v 1.3 2005/03/19 03:40:58 vapier Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm hppa m68k ia64 ppc ppc64 s390 sh sparc x86"
inherit kernel-2 eutils
detect_version

SRC_URI="${KERNEL_URI} mirror://gentoo/linux-2.6.11-m68k-headers.patch.bz2"
KEYWORDS="-* m68k" # Not tested to be fully stable, if things break file bugs to plasmaroo please...

UNIPATCH_LIST="
	${FILESDIR}/${PN}-2.6.0-sysctl_h-compat.patch
	${FILESDIR}/${PN}-2.6.0-fb.patch
	${FILESDIR}/${PN}-2.6.8.1-strict-ansi-fix.patch
	${FILESDIR}/${P}-appCompat.patch
	${FILESDIR}/${PN}-2.6.10-generic-arm-prepare.patch
	${FILESDIR}/${PN}-soundcard-ppc64.patch"

src_unpack() {
	tc-arch-kernel
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
}
