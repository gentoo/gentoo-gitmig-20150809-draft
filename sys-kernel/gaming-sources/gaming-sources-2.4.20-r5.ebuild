# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gaming-sources/gaming-sources-2.4.20-r5.ebuild,v 1.11 2004/01/24 19:22:55 plasmaroo Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  

ETYPE="sources"

inherit kernel

OKV="2.4.20"
EXTRAVERSION="-gaming-r5"
KV="${OKV}${EXTRAVERSION}"
S=${WORKDIR}/linux-${KV}
CKV=4_2.4.20

DESCRIPTION="Full sources for the Gentoo gaming-optimized kernel"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2 mirror://gentoo/patches-${KV}.tar.bz2 http://members.optusnet.com.au/ckolivas/kernel/ck${CKV}.patch.bz2"

KEYWORDS="x86"
SLOT="${KV}"

src_unpack() {

	unpack linux-${OKV}.tar.bz2 patches-${KV}.tar.bz2
	bzcat ${DISTDIR}/ck${CKV}.patch.bz2 | patch -p0 || die "-patch failed"

	mv linux-${OKV} linux-${KV} || die

	cd ${KV} || die #enter the patch directory and go!
	kernel_src_unpack

	epatch ${FILESDIR}/do_brk_fix.patch || die "failed to patch for do_brk vuln"

	# Bug #32135
	sed -i '1201d' ../linux-${KV}/drivers/net/fealnx.c

}
