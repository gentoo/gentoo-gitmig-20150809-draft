# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/win4lin-sources/win4lin-sources-2.4.20-r1.ebuild,v 1.1 2002/12/12 18:47:07 lostlogic Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV="2.4.20"

#add one of these in if this is for a pre or rc kernel
#KERN_PATCH="patch-2.4.20-rc1.bz2"

DESCRIPTION="Full sources for the latest ACPI Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 https://www.netraverse.com/member/downloads/files/mki-adapter.patch
	 https://www.netraverse.com/member/downloads/files/Kernel-Win4Lin3-${OKV}.patch"
#http://www.kernel.org/pub/linux/kernel/v2.4/testing/${KERN_PATCH}

KEYWORDS="x86"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}

#	bzcat ${DISTDIR}/${KERN_PATCH}|patch -p1 || die "-marcelo patch failed"
	cat ${DISTDIR}/mki-adapter_1_0_7.patch|patch -p1 || die "-mki-adapter patch failed"
	cat ${DISTDIR}/Kernel-Win4Lin3-${OKV}.patch|patch -p1 || die "-Win4Lin3 patch failed"

	kernel_universal_unpack
}
