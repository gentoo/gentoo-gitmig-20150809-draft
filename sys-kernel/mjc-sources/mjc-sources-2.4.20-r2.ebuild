# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mjc-sources/mjc-sources-2.4.20-r2.ebuild,v 1.2 2002/10/01 13:05:56 lostlogic Exp $

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV=2.4.19
DESCRIPTION="Full sources for MJC's Gentoo Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.kernel.org/pub/linux/kernel/v2.4/testing/patch-2.4.20-pre7.bz2
	 mirror://gentoo/patch-${KV}.bz2"
KEYWORDS="x86 -ppc -sparc -sparc64"

src_unpack() {

	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}
	bzcat ${DISTDIR}/patch-2.4.20-pre7.bz2|patch -p1 || die "patch 1 failed"
	bzcat ${DISTDIR}/patch-${KV}.bz2 | patch -p1 || die "patch 2 failed"

	kernel_universal_unpack

}
