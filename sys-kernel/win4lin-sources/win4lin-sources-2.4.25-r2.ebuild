# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/win4lin-sources/win4lin-sources-2.4.25-r2.ebuild,v 1.2 2004/04/27 22:12:33 agriffis Exp $

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

IUSE=""
ETYPE="sources"
inherit kernel eutils
OKV="2.4.25"
KV="2.4.25-win4lin-${PR}"
EXTRAVERSION="-win4lin-${PR}"

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the Linux kernel, with Win4Lin support."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.netraverse.com/member/downloads/files/mki-adapter.patch
	 http://www.netraverse.com/member/downloads/files/Kernel-Win4Lin3-${OKV}.patch"
HOMEPAGE="http://www.kernel.org/ http://www.netraverse.com/"
KEYWORDS="x86"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}
	epatch ${DISTDIR}/Kernel-Win4Lin3-${OKV}.patch || die "Error: Win4Lin3 patch failed."
	patch -Np1 -i ${DISTDIR}/mki-adapter.patch >/dev/null 2>&1 || die "Error: mki-adapter patch failed."
	epatch ${FILESDIR}/${P}.CAN-2004-0109.patch || die "Failed to patch CAN-2004-0109 vulnerability!"
	epatch ${FILESDIR}/${P}.CAN-2004-0177.patch || die "Failed to add the CAN-2004-0177 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0178.patch || die "Failed to add the CAN-2004-0178 patch!"

	kernel_universal_unpack
}
