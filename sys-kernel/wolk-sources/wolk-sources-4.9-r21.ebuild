# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/wolk-sources/wolk-sources-4.9-r21.ebuild,v 1.1 2005/03/26 18:41:50 plasmaroo Exp $

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

IUSE="build wolk-bootsplash wolk-supermount ipv6"
ETYPE="sources"

inherit kernel eutils

OKV=2.4.20
EXTRAVERSION="-${PN/-*/}4.9s-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}
DESCRIPTION="Working Overloaded Linux Kernel (Server-Edition)"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa -mips"
SRC_PATH="mirror://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2"

SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.0s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.0s-to-4.1s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.1s-to-4.2s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.2s-to-4.3s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.3s-to-4.4s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.4s-to-4.5s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.5s-to-4.6s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.6s-to-4.7s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.7s-to-4.8s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.8s-to-4.9s.patch.bz2
		wolk-bootsplash? ( http://wolk.sourceforge.net/Workstation-Edition/1007_bootsplash-v3.0.7-2.4.20-0.patch
			http://wolk.sourceforge.net/Workstation-Edition/1007_bootsplash-v3.0.7-2.4.20-1-aty128.patch
			http://wolk.sourceforge.net/Workstation-Edition/1007_bootsplash-v3.0.8-2.4.20-update.patch)
		wolk-supermount? ( http://wolk.sourceforge.net/Workstation-Edition/1008_supermount-1.2.9-2.4.20-OLDIDE.patch)
		ipv6? ( http://wolk.sourceforge.net/Workstation-Edition/1009_mipv6-0.9.5.1-v2.4.20-wolk4.0s.patch )
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${P}-CAN-2004-0415.patch
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${P}-CAN-2004-0814.2.patch"

SLOT="${KV}"
HOMEPAGE="http://wolk.sourceforge.net http://www.kernel.org"

src_unpack() {
	local PATCHFILES="-wolk4.0s -wolk4.0s-to-4.1s -wolk4.1s-to-4.2s -wolk4.2s-to-4.3s -wolk4.3s-to-4.4s -wolk4.4s-to-4.5s -wolk4.5s-to-4.6s -wolk4.6s-to-4.7s -wolk4.7s-to-4.8s -wolk4.8s-to-4.9s"
	unpack linux-${OKV}.tar.bz2 || die

	mv linux-${OKV} linux-${KV} || die
	cd ${WORKDIR}/linux-${KV} || die
	for PATCHES in ${PATCHFILES}
	do
		epatch ${DISTDIR}/linux-${OKV}${PATCHES}.patch.bz2 || die
	done

	einfo "Applying NVIDIA patches..."
	epatch ${FILESDIR}/wolk-4.9s-page.h.patch || die
	epatch ${FILESDIR}/wolk-4.9s-setup.c.patch || die

	einfo "Applying other needed patches..."
	epatch ${FILESDIR}/wolk-4.9s-speedstep.c.patch || die

	if use wolk-supermount; then
		ewinfo "Applying Supermount patch..."
		epatch ${DISTDIR}/1008_supermount-1.2.9-2.4.20-OLDIDE.patch  || die
	fi
	if use ipv6; then
		einfo "Applying MIPv6 patch..."
		epatch ${DISTDIR}/1009_mipv6-0.9.5.1-v2.4.20-wolk4.0s.patch  || die
	fi

	if use wolk-bootsplash; then
		einfo "Applying Bootsplash patches..."
		epatch ${DISTDIR}/1007_bootsplash-v3.0.7-2.4.20-0.patch  || die
		epatch ${DISTDIR}/1007_bootsplash-v3.0.7-2.4.20-1-aty128.patch  || die
		epatch ${DISTDIR}/1007_bootsplash-v3.0.8-2.4.20-update.patch || die
	fi

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch for do_brk() vulnerability!"
	epatch ${FILESDIR}/${PN}-4.9s.munmap.patch || die "Failed to apply munmap patch!"
	epatch ${FILESDIR}/${PN}-4.9s.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"
	epatch ${FILESDIR}/${PN}-4.9s.CAN-2004-0010.patch || die "Failed to add the CAN-2004-0010 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2003-0643.patch || die "Failed to add the CAN-2003-0643 patch!"
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
	epatch ${FILESDIR}/${PN}-4.9s.CAN-2004-0685.patch || die "Failed to add the CAN-2004-0685 patch!"
	epatch ${DISTDIR}/${P}-CAN-2004-0814.2.patch || die "Failed to add the CAN-2004-0814 patch!"
	epatch ${FILESDIR}/${PN}.FPULockup-53804.patch || die "Failed to apply FPU-lockup patch!"
	epatch ${FILESDIR}/${PN}.cmdlineLeak.patch || die "Failed to apply the /proc/cmdline patch!"
	epatch ${FILESDIR}/${PN}.XDRWrapFix.patch || die "Failed to apply the kNFSd XDR patch!"
	epatch ${FILESDIR}/${PN}.binfmt_elf.patch || die "Failed to apply the binfmt_elf patch!"
	epatch ${FILESDIR}/${PN}.smbfs.patch || die "Failed to apply the SMBFS patch!"
	epatch ${FILESDIR}/${PN}.AF_UNIX.patch || die "Failed to apply the AF_UNIX patch!"
	epatch ${FILESDIR}/${PN}.binfmt_a.out.patch || die "Failed to apply the binfmt_a.out patch!"
	epatch ${FILESDIR}/${PN}.vma.patch || die "Failed to apply the VMA patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-1016.patch || die "Failed to apply the CAN-2004-1016 patch!"
	epatch ${FILESDIR}/${PN}-4.9s.CAN-2004-1056.patch || die "Failed to apply the CAN-2004-1056 patch!"
	epatch ${FILESDIR}/${PN}-4.9s.brk-locked.patch || die "Failed to apply the do_brk() locking patch!"
	epatch ${FILESDIR}/${PN}.77094.patch || die "Failed to apply bug #77094 patch!"
	epatch ${FILESDIR}/${PN}-4.9s.77666.patch || die "Failed to apply bug #77666 patch!"
	epatch ${FILESDIR}/${PN}.78362.patch || die "Failed to apply bug #78362 patch!"
	epatch ${FILESDIR}/${PN}.78363.patch || die "Failed to apply bug #78363 patch!"
	epatch ${FILESDIR}/${PN}.81106.patch || die "Failed to apply bug #81106 patch!"

	kernel_universal_unpack
}

pkg_postinst() {
	einfo
	einfo "Since wolk-sources-4.6s the 3com 3c59x v0.99Za drivers are excluded."
	einfo "For many people they may work, but too many people expecting problems"
	einfo "with this drivers. They will be reintroduced when they are fixed."
	einfo "You have to fall back to an earlier release of the wolk kernel when you want"
	einfo "to use one of these drivers."
	einfo
	einfo "This new ebuild has support for the workstation patches."
	einfo "With the wolk-bootsplash, wolk-supermount, and"
	einfo "ipv6 use flags you can take advantage of the"
	einfo "Bootsplash, Supermount, and MIPv6 patches."
	einfo
	ewarn "Patches not guaranteed; YMMV..."
	einfo
}
