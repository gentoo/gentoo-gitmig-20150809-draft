# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.16.ebuild,v 1.2 2006/04/18 15:39:32 plasmaroo Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm hppa m68k ia64 ppc ppc64 s390 sh sparc x86"
inherit eutils kernel-2 multilib
detect_version

PATCHES_V='2'

SRC_URI="${KERNEL_URI} mirror://gentoo/linux-2.6.11-m68k-headers.patch.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-headers/gentoo-headers-${PV}-${PATCHES_V}.tar.bz2"
KEYWORDS="-*"

DEPEND="ppc? ( gcc64? ( sys-devel/gcc-powerpc64 ) )
		sparc? ( gcc64? ( sys-devel/gcc-sparc64 ) )"

UNIPATCH_LIST="${DISTDIR}/gentoo-headers-${PV}-${PATCHES_V}.tar.bz2"

wrap_headers_fix() {
	for i in $*
	do
		echo -n " $1/"
		cd ${S}/include/$1
		headers___fix $(find . -type f -print)
		shift
	done
	echo
}

src_unpack() {
	ABI=${KERNEL_ABI}
	kernel-2_src_unpack

	# This should always be used but it has a bunch of hunks which
	# apply to include/linux/ which i'm unsure of so only use with
	# m68k for now (dont want to break other arches)
	[[ $(tc-arch) == "m68k" ]] && epatch "${DISTDIR}"/linux-2.6.11-m68k-headers.patch.bz2

	# Get headers to bootstrap on PPC
	if use ppc; then
		cp arch/powerpc/configs/pmac32_defconfig arch/powerpc/configs/ppc_defconfig
	fi

	# Fixes ... all the wrapper magic is to keep sed from dumping
	# ugly warnings about how it can't work on a directory.
	cd "${S}"/include
	einfo "Applying automated fixes:"
	wrap_headers_fix asm-* linux
	einfo "... done"
}
