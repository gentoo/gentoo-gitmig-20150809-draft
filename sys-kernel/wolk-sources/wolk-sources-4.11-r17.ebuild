# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/wolk-sources/wolk-sources-4.11-r17.ebuild,v 1.1 2005/03/26 18:41:50 plasmaroo Exp $

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel eutils
IUSE=""
OKV=2.4.20
KV=${OKV}-wolk4.11s-${PR}
EXTRAVERSION=-wolk4.11s-${PR}

S=${WORKDIR}/linux-${KV}
DESCRIPTION="Working Overloaded Linux Kernel (Server-Edition)"

KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa -mips"

SRC_PATH="mirror://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.10s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.10s-to-4.11s.patch.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${P}-CAN-2004-0415.patch
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${PN}-4.9-CAN-2004-0814.2.patch"

SLOT="${KV}"
HOMEPAGE="http://wolk.sourceforge.net http://www.kernel.org"

src_unpack() {
	unpack linux-${OKV}.tar.bz2 || die
	mv linux-${OKV} linux-${KV} || die
	cd ${WORKDIR}/linux-${KV} || die
	epatch ${DISTDIR}/linux-${OKV}-wolk4.10s.patch.bz2 || die
	epatch ${DISTDIR}/linux-${OKV}-wolk4.10s-to-4.11s.patch.bz2 || die

	epatch ${FILESDIR}/${PN}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0109.patch || die "Failed to add the CAN-2004-0109 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0133.patch || die "Failed to add the CAN-2004-0133 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0177.patch || die "Failed to add the CAN-2004-0177 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0178.patch || die "Failed to add the CAN-2004-0178 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0181.patch || die "Failed to add the CAN-2004-0181 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0394.patch || die "Failed to add the CAN-2004-0394 patch!"
	epatch ${DISTDIR}/${P}-CAN-2004-0415.patch || die "Failed to add the CAN-2004-0415 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0427.patch || die "Failed to add the CAN-2004-0427 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0495.patch || die "Failed to add the CAN-2004-0495 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0497.patch || die "Failed to add the CAN-2004-0497 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0535.patch || die "Failed to add the CAN-2004-0535 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0685.patch || die "Failed to add the CAN-2004-0685 patch!"
	epatch ${DISTDIR}/${PN}-4.9-CAN-2004-0814.2.patch || die "Failed to add the CAN-2004-0814 patch!"
	epatch ${FILESDIR}/${PN}.FPULockup-53804.patch || die "Failed to apply FPU-lockup patch!"
	epatch ${FILESDIR}/${PN}.cmdlineLeak.patch || die "Failed to apply the /proc/cmdline patch!"
	epatch ${FILESDIR}/${PN}.XDRWrapFix.patch || die "Failed to apply the kNFSd XDR patch!"
	epatch ${FILESDIR}/${PN}.binfmt_elf.patch || die "Failed to apply the binfmt_elf patch!"
	epatch ${FILESDIR}/${PN}.smbfs.patch || die "Failed to apply the SMBFS patch!"
	epatch ${FILESDIR}/${PN}.AF_UNIX.patch || die "Failed to apply the AF_UNIX patch!"
	epatch ${FILESDIR}/${PN}.binfmt_a.out.patch || die "Failed to apply the binfmt_a.out patch!"
	epatch ${FILESDIR}/${PN}.vma.patch || die "Failed to apply the VMA patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-1016.patch || die "Failed to apply the CAN-2004-1016 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-1056.patch || die "Failed to apply the CAN-2004-1056 patch!"
	epatch ${FILESDIR}/${PN}.brk-locked.patch || die "Failed to apply the do_brk() locking patch!"
	epatch ${FILESDIR}/${PN}.77094.patch || die "Failed to apply bug #77094 patch!"
	epatch ${FILESDIR}/${PN}.77666.patch || die "Failed to apply bug #77666 patch!"
	epatch ${FILESDIR}/${PN}.78362.patch || die "Failed to apply bug #78362 patch!"
	epatch ${FILESDIR}/${PN}.78363.patch || die "Failed to apply bug #78363 patch!"
	epatch ${FILESDIR}/${PN}.81106.patch || die "Failed to apply bug #81106 patch!"

	kernel_universal_unpack
}

pkg_postinst() {
	einfo
	einfo "This is the base WOLK 4.11 Server Edition with all"
	einfo "recent security fixes, but no workstation patches."
	einfo
}
