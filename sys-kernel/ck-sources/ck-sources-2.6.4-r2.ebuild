# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.4-r2.ebuild,v 1.5 2004/05/30 23:53:41 pvdabeel Exp $

UNIPATCH_LIST="${DISTDIR}/patch-${KV}.bz2 ${FILESDIR}/${P}.CAN-2004-0075.patch ${FILESDIR}/${P}.CAN-2004-0109.patch ${FILESDIR}/${P}.CAN-2004-0181.patch ${FILESDIR}/${P}.CAN-2004-0228.patch ${FILESDIR}/${P}.CAN-2004-0229.patch ${FILESDIR}/${P}.CAN-2004-0427.patch"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version
IUSE=""

DESCRIPTION="Full sources for the Stock Linux kernel Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="${KERNEL_URI} http://ck.kolivas.org/patches/2.6/${KV/-ck*/}/${KV}/patch-${KV}.bz2"

KEYWORDS="~x86 ~ppc"

pkg_postinst() {
	postinst_sources

	ewarn "IMPORTANT:"
	ewarn "ptyfs support has now been dropped from devfs and as a"
	ewarn "result you are now required to compile this support into"
	ewarn "the kernel. You can do so by enabling the following options"
	ewarn "    Device Drivers -> Character devices  -> Unix98 PTY Support"
	ewarn "    File systems   -> Pseudo filesystems -> /dev/pts filesystem."
	echo
}
