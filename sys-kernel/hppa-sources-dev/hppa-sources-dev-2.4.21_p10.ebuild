# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-sources-dev/hppa-sources-dev-2.4.21_p10.ebuild,v 1.3 2003/09/07 07:26:00 msterret Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel
OKV="${PV/_p*/}"
PATCH_LEVEL="${PV/${OKV}_p/}"
EXTRAVERSION="-pa${PATCH_LEVEL}-dev"
KV=${OKV}${EXTRAVERSION}
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
# stock 2.4.20 kernel sources
# patches for hppa

PATCH_BASE="7"

DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://ftp.parisc-linux.org/cvs/linux-2.4/patch-${OKV}-pa${PATCH_BASE}.diff.gz
`for i in \`seq $((PATCH_BASE + 1)) ${PATCH_LEVEL}\`; do echo http://ftp.parisc-linux.org/cvs/linux-2.4/patch-${OKV}-pa$((i - 1))-pa${i}.gz; done`
http://dev.gentoo.org/~gmsoft/${PN}-${OKV}-grsec-crypto-r1.diff.bz2
http://dev.gentoo.org/~gmsoft/hppa-sources-dev-grsec-hppa64-fix.patch"
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
		zcat ${DISTDIR}/patch-${OKV}-pa$((i - 1))-pa${i}.gz | patch -sp 1 > /dev/null
	done

	einfo Patching for grsecurity and CryptoApi support
	bzcat ${DISTDIR}/${PN}-${OKV}-grsec-crypto-r1.diff.bz2 | patch -sp 1
	einfo Fixing grsec on hppa64
	cat ${DISTDIR}/hppa-sources-dev-grsec-hppa64-fix.patch | patch -sp 1

	kernel_universal_unpack
}
