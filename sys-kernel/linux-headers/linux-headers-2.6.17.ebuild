# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.17.ebuild,v 1.7 2006/09/04 02:02:20 vapier Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm hppa m68k ia64 ppc ppc64 s390 sh sparc x86"
inherit eutils multilib kernel-2
detect_version

PATCHES_V='3'

SRC_URI="${KERNEL_URI} mirror://gentoo/linux-2.6.17-m68k-headers.patch.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-headers/gentoo-headers-${PV}-${PATCHES_V}.tar.bz2"
KEYWORDS="-* ~arm ~m68k ~ppc64 ~sh ~x86"

DEPEND="ppc? ( gcc64? ( sys-devel/gcc-powerpc64 ) )
		sparc? ( gcc64? ( sys-devel/gcc-sparc64 ) )"

UNIPATCH_LIST="${DISTDIR}/linux-2.6.17-m68k-headers.patch.bz2
	${DISTDIR}/gentoo-headers-${PV}-${PATCHES_V}.tar.bz2"

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

	# Fixes ... all the wrapper magic is to keep sed from dumping
	# ugly warnings about how it can't work on a directory.
	cd "${S}"/include
	einfo "Applying automated fixes:"
	wrap_headers_fix asm-* linux
	einfo "... done"
}
