# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ac-sources/ac-sources-2.4.20_pre83.ebuild,v 1.1 2002/10/06 18:48:59 lostlogic Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  

ETYPE="sources"

inherit kernel || die

OKV="2.4.19"
KV="2.4.20-pre8-ac3"
S=${WORKDIR}/linux-${KV}

EXTRAVERSION="-pre8-ac3"

DESCRIPTION="Full sources for Alan Cox's Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.kernel.org/pub/linux/kernel/v2.4/testing/patch-${KV/-ac3/}.bz2
	 http://www.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.20/patch-${KV}.bz2"

KEYWORDS="x86"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}

	bzcat ${DISTDIR}/patch-${KV/-ac3/}.bz2|patch -p1 || die "-marcelo patch failed"
	bzcat ${DISTDIR}/patch-${KV}.bz2|patch -p1 || die "-ac patch failed"

	kernel_universal_unpack
}
