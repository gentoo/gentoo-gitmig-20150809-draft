# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/acpi-sources/acpi-sources-2.4.20-r8.ebuild,v 1.2 2002/12/18 00:12:48 lostlogic Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV="2.4.20"

ACPI_PATCH="acpi-20021205-2.4.20.diff.gz"

#add one of these in if this is for a pre or rc kernel
#KERN_PATCH="patch-2.4.20-rc1.bz2"

DESCRIPTION="Full sources for the latest ACPI Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 mirror://sourceforge/acpi/${ACPI_PATCH}"
#http://www.kernel.org/pub/linux/kernel/v2.4/testing/${KERN_PATCH}

KEYWORDS="x86"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}

#	bzcat ${DISTDIR}/${KERN_PATCH}|patch -p1 || die "-marcelo patch failed"
	zcat ${DISTDIR}/${ACPI_PATCH}|patch -p1 || die "-acpi patch failed"

	kernel_universal_unpack
}
