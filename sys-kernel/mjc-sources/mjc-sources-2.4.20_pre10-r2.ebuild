# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mjc-sources/mjc-sources-2.4.20_pre10-r2.ebuild,v 1.5 2003/02/13 16:39:53 vapier Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV=2.4.19
KV=2.4.20-pre10-mjc2
EXTRAVERSION=-pre10-mjc2
S=${WORKDIR}/linux-${KV}
DESCRIPTION="Full sources for MJC's Gentoo Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.kernel.org/pub/linux/kernel/people/mjc/patches-${KV}.tar.bz2"
KEYWORDS="x86 -ppc -sparc "
SLOT="${KV}"

src_unpack() {

	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	unpack patches-${KV}.tar.bz2
	cd ${KV}

	kernel_src_unpack

	cd ${WORKDIR}/linux-${KV}
	patch -p1 < ${FILESDIR}/linux-${KV}-gentoo.diff || die "Quickfixes failed"

}
