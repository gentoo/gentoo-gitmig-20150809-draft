# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/acpi-sources/acpi-sources-2.4.20-r5.ebuild,v 1.1 2002/10/06 18:46:20 lostlogic Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV="2.4.19"

ACPI_PATCH="acpi-20021002-2.4.20-pre8.diff.gz"
KERN_PATCH="patch-2.4.20-pre8.bz2"

DESCRIPTION="Full sources for the latest ACPI Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.kernel.org/pub/linux/kernel/v2.4/testing/${KERN_PATCH}
	 http://unc.dl.sourceforge.net/sourceforge/acpi/${ACPI_PATCH}"

KEYWORDS="x86"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}

	bzcat ${DISTDIR}/${KERN_PATCH}|patch -p1 || die "-marcelo patch failed"
	zcat ${DISTDIR}/${ACPI_PATCH}|patch -p1 || die "-acpi patch failed"

	kernel_universal_unpack
}
