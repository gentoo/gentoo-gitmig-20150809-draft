# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:
#/home/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.4.20.ebuild,v1.2 2002/11/28 18:24:38 gerk Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  

ETYPE="sources"

inherit kernel || die

OKV="2.4.20"
KV="2.4.20-ck1"
S=${WORKDIR}/linux-${KV}

EXTRAVERSION="-ck1"
DESCRIPTION="Full sources for the Stock Linux kernel Con Kolivas's high performance patchset"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://members.optusnet.com.au/con.man/ck1_${OKV}.patch.bz2"

KEYWORDS="x86 -ppc"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	bzcat ${DISTDIR}/ck1_${OKV}.patch.bz2 | patch -p0 || die "-patch failed"

	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}

	kernel_universal_unpack
}


