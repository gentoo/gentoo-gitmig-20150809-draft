# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/win4lin-sources/win4lin-sources-2.4.26-r13.ebuild,v 1.1 2005/03/25 19:40:07 plasmaroo Exp $

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

IUSE=""
ETYPE="sources"
inherit kernel eutils
OKV="2.4.26"
EXTRAVERSION="-win4lin-${PR}"
KV="2.4.26${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the Linux kernel, with Win4Lin support."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.netraverse.com/member/downloads/files/mki-adapter.patch
	 http://www.netraverse.com/member/downloads/files/Kernel-Win4Lin3-${OKV}.patch
	 http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch
	 http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0814.2.patch"
HOMEPAGE="http://www.kernel.org/ http://www.netraverse.com/"
KEYWORDS="x86"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}
	epatch ${DISTDIR}/Kernel-Win4Lin3-${OKV}.patch || die "Error: Win4Lin3 patch failed."
	ebegin 'Applying mki-adapter.patch'
	patch -Np1 -i ${DISTDIR}/mki-adapter.patch >/dev/null 2>&1 || die "Error: mki-adapter patch failed."
	eend $?
	epatch ${FILESDIR}/${P}.CAN-2004-0394.patch || die "Failed to add the CAN-2004-0394 patch!"
	epatch ${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch || die "Failed to add the CAN-2004-0415 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0495.patch || die "Failed to add the CAN-2004-0495 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0497.patch || die "Failed to add the CAN-2004-0497 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0535.patch || die "Failed to add the CAN-2004-0535 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0685.patch || die "Failed to add the CAN-2004-0685 patch!"
	epatch ${DISTDIR}/linux-${OKV}-CAN-2004-0814.2.patch || die "Failed to add the CAN-2004-0814 patch!"
	epatch ${FILESDIR}/${P}.FPULockup-53804.patch || die "Failed to apply FPU-lockup patch!"
	epatch ${FILESDIR}/${P}.cmdlineLeak.patch || die "Failed to apply the /proc/cmdline patch!"
	epatch ${FILESDIR}/${P}.XDRWrapFix.patch || die "Failed to apply the kNFSd XDR patch!"
	epatch ${FILESDIR}/${P}.binfmt_elf.patch || die "Failed to apply the binfmt_elf patch!"
	epatch ${FILESDIR}/${P}.smbfs.patch || die "Failed to apply the SMBFS patch!"
	epatch ${FILESDIR}/${PN}.AF_UNIX.patch || die "Failed to apply the AF_UNIX patch!"
	epatch ${FILESDIR}/${P}.binfmt_a.out.patch || die "Failed to apply the a.out patch!"
	epatch ${FILESDIR}/${P}.vma.patch || die "Failed to apply the VMA patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-1016.patch || die "Failed to apply the CAN-2004-1016 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-1056.patch || die "Failed to apply the CAN-2004-1056 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-1137.patch || die "Failed to apply the CAN-2004-1137 patch!"
	epatch ${FILESDIR}/${P}.77094.patch || die "Failed to apply bug #77094 patch!"
	epatch ${FILESDIR}/${P}.brk-locked.patch || die "Failed to apply do_brk_locked() patch!"
	epatch ${FILESDIR}/${P}.77666.patch || die "Failed to apply #77666 patch!"
	epatch ${FILESDIR}/${P}.78362.patch || die "Failed to apply #78362 patch!"
	epatch ${FILESDIR}/${P}.78363.patch || die "Failed to apply #78363 patch!"

	kernel_universal_unpack
}

