# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/aa-sources/aa-sources-2.4.20_pre101.ebuild,v 1.3 2002/12/18 00:12:48 lostlogic Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  

ETYPE="sources"

inherit kernel || die

OKV="2.4.19"
KV="2.4.20-pre10-aa1"
S=${WORKDIR}/linux-${KV}

EXTRAVERSION="-pre10-aa1"

DESCRIPTION="Full sources for Andrea Arcangeli's Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
http://www.kernel.org/pub/linux/kernel/v2.4/testing/patch-${KV/-aa1/}.bz2
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/${KV//-/}.bz2"

KEYWORDS="x86 -ppc"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}

	bzcat ${DISTDIR}/patch-${KV/-aa1/}.bz2|patch -p1 || die "-marcelo patch failed"
	bzcat ${DISTDIR}/${KV//-/}.bz2|patch -p1 || die "-aa patch failed"

	kernel_universal_unpack
}

