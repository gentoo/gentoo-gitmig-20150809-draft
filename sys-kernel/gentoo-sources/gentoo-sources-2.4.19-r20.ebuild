# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.19-r20.ebuild,v 1.1 2004/08/04 22:06:42 plasmaroo Exp $

IUSE="acpi4linux crypt xfs"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

# Kernel ebuilds using the kernel.eclass can remove any patch that you
# do not want to apply by simply setting the KERNEL_EXCLUDE shell
# variable to the string you want to exclude (for instance
# KERNEL_EXCLUDE="evms" would not patch any patches whose names match
# *evms*).  Kernels are only tested in the default configuration, but
# this may be useful if you know that a particular patch is causing a
# conflict with a patch you personally want to apply, or some other
# similar situation.

# This kernel also has support for the local USE flag acpi4linux which
# activates the latest code from acpi.sourceforge.net instead of the
# very out of date vanilla version

ETYPE="sources"

inherit kernel eutils

OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://gentoo.lostlogicx.com/patches-${KV/-r20/-r10}.tar.bz2
	 http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch"
KEYWORDS="x86 -ppc -sparc -amd64 -ia64"
SLOT="${KV}"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	cd ${KV/-r20/-r10}
	# Kill patches we aren't suppposed to use, don't worry about
	# failures, if they aren't there that is a good thing!

	# This is the ratified crypt USE flag, enables IPSEC and patch-int
	use crypt || rm 8*

	# This is the XFS filesystem from SGI, use at your own risk ;)
	use xfs || rm *xfs*

	# This is the latest release of ACPI from
	# http://www.sourceforge.net/projects/acpi
	use acpi4linux || rm 70*

	kernel_src_unpack

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc33.patch || die "GCC 3.3 patch failed!"
	epatch ${FILESDIR}/${PN}-2.4.20-cs46xx-gcc33.patch || die "GCC 3.3 patch failed!"

	epatch ${FILESDIR}/security.patch2
	epatch ${FILESDIR}/security.patch3
	epatch ${FILESDIR}/security.patch4

	epatch ${FILESDIR}/lcall-DoS.patch || die "lcall-DoS patch failed"
	epatch ${FILESDIR}/i810_drm.patch || die "i810_drm patch failed"
	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to apply do_brk() patch!"
	epatch ${FILESDIR}/${P}-munmap.patch || die "Failed to apply munmap patch!"
	epatch ${FILESDIR}/${P}-rtc_fix.patch || die "Failed to apply the RTC fixes!"
	epatch ${FILESDIR}/${PN}-2.4.CAN-2003-0643.patch || die "Failed to add the CAN-2003-0643 patch!"
	epatch ${FILESDIR}/${PN}-2.4.CAN-2003-0985.patch || die "Failed to add the CAN-2003-0985 patch!"
	epatch ${FILESDIR}/${PN}-2.4.CAN-2004-0010.patch || die "Failed to add the CAN-2004-0010 patch!"
	epatch ${FILESDIR}/${PN}-2.4.CAN-2004-0109.patch || die "Failed to add the CAN-2004-0109 patch!"
	use xfs && { epatch ${FILESDIR}/${PN}-2.4.CAN-2004-0133.patch || die "Failed to add the CAN-2004-0133 patch!"; }
	epatch ${FILESDIR}/${PN}-2.4.CAN-2004-0177.patch || die "Failed to add the CAN-2004-0177 patch!"
	epatch ${FILESDIR}/${PN}-2.4.CAN-2004-0178.patch || die "Failed to add the CAN-2004-0178 patch!"
	epatch ${FILESDIR}/${P}-CAN-2004-0181.patch || die "Failed to add the CAN-2004-0181 patch!"
	epatch ${FILESDIR}/${PN}-2.4.CAN-2004-0394.patch || die "Failed to add the CAN-2004-0394 patch!"
	epatch ${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch || die "Failed to add the CAN-2004-0415 patch!"
	epatch ${FILESDIR}/${PN}-2.4.CAN-2004-0427.patch || die "Failed to add the CAN-2004-0427 patch!"
	epatch ${FILESDIR}/${PN}-2.4.CAN-2004-0495.patch || die "Failed to add the CAN-2004-0495 patch!"
	epatch ${FILESDIR}/${PN}-2.4.CAN-2004-0497.patch || die "Failed to add the CAN-2004-0497 patch!"
	epatch ${FILESDIR}/${PN}-2.4.FPULockup-53804.patch || die "Failed to apply FPU-lockup patch!"
}
