# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/win4lin-sources/win4lin-sources-2.4.22.ebuild,v 1.4 2003/12/02 00:36:23 iggy Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel

OKV="2.4.22"
KV="2.4.22-win4lin"
EXTRAVERSION="-win4lin"

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the linux kernel with win4lin support"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.netraverse.com/member/downloads/files/mki-adapter.patch
	 http://www.netraverse.com/member/downloads/files/Kernel-Win4Lin3-${OKV}.patch"

KEYWORDS="~x86"
SLOT="${KV}"

src_unpack() {

	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	epatch ${DISTDIR}/Kernel-Win4Lin3-${OKV}.patch || die "Error: Win4Lin3 patch failed!"

	cd linux-${KV}
	cat ${DISTDIR}/mki-adapter.patch | patch -p1 &> /dev/null || die "Error: mki-adapter patch failed!"

	epatch ${FILESDIR}/do_brk_fix.patch || die "failed to patch for do_brk vuln"

	kernel_universal_unpack

}
