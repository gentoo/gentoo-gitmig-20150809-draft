# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.4.20-r1.ebuild,v 1.3 2002/12/17 22:13:47 lostlogic Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  

ETYPE="sources"

inherit kernel || die

OKV="2.4.20"
KV="2.4.20-ck1"
S=${WORKDIR}/linux-${KV}

EXTRAVERSION="-ck1"
DESCRIPTION="Full sources for the Stock Linux kernel Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://members.optusnet.com.au/con.man/ck${PR/r/}_${OKV}.patch.bz2"

KEYWORDS="x86 -ppc"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	bzcat ${DISTDIR}/ck1_${OKV}.patch.bz2 | patch -p0 || die "-patch failed"

	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}

	kernel_universal_unpack
}


