# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-sources/hppa-sources-2.4.21_p9.ebuild,v 1.4 2004/01/06 19:58:13 plasmaroo Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel
OKV="${PV/_p*/}"
PATCH_LEVEL="${PV/${OKV}_p/}"
KV=${OKV}-pa${PATCH_LEVEL}
EXTRAVERSION="-pa${PATCH_LEVEL}"
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
# stock 2.4.20 kernel sources
# patches for hppa

PATCH_BASE="7"

DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://ftp.parisc-linux.org/cvs/linux-2.4/patch-${OKV}-pa${PATCH_BASE}.diff.gz
`for i in \`seq $((PATCH_BASE + 1)) ${PATCH_LEVEL}\`; do echo http://ftp.parisc-linux.org/cvs/linux-2.4/patch-${OKV}-pa$((i - 1))-pa${i}.gz; done`"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org"
KEYWORDS="hppa -*"
SLOT="${KV}"


src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${KV}
	cd ${S}

	einfo Applying ${OKV}-pa${PATCH_BASE}
	zcat ${DISTDIR}/patch-${OKV}-pa${PATCH_BASE}.diff.gz | patch -sp 1

	for i in `seq $((PATCH_BASE + 1)) ${PATCH_LEVEL}`
	do
		einfo Applying patch from ${OKV}-pa$((i - 1)) to  ${OKV}-pa${i}
		zcat ${DISTDIR}/patch-${OKV}-pa$((i - 1))-pa${i}.gz | patch -sp 1
	done

	einfo Please ignore any "Hunk failed" above error if any

	kernel_universal_unpack
}
