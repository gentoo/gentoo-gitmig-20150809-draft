# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-sources/hppa-sources-2.4.20_p27.ebuild,v 1.1 2003/02/19 12:40:09 gmsoft Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel
OKV=2.4.20
HPPA_PATCH_LEVEL="27"
KV=2.4.20-pa${HPPA_PATCH_LEVEL}
EXTRAVERSION="-pa${HPPA_PATCH_LEVEL}"
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
# stock 2.4.20 kernel sources
# patches for hppa

DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://ftp.parisc-linux.org/cvs/patch-${OKV}-pa${HPPA_PATCH_LEVEL}.diff.gz"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/" 
KEYWORDS="~hppa -x86 -ppc -sparc -alpha -mips"
SLOT="${KV}"


src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${KV}
	cd ${S}
    KV="${OKV}-pa${HPPA_PATCH_LEVEL}"
	unpack patch-${OKV}-pa${HPPA_PATCH_LEVEL}.diff.gz
	patch -p 1 < ${S}/patch-${OKV}-pa${HPPA_PATCH_LEVEL}.diff


	kernel_universal_unpack
}
