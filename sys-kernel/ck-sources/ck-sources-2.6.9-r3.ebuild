# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.9-r3.ebuild,v 1.9 2004/12/20 20:20:39 plasmaroo Exp $

UNIPATCH_LIST="${DISTDIR}/patch-${KV}.bz2
	${FILESDIR}/${P}.binfmt_elf.patch
	${FILESDIR}/${P}.binfmt_a.out.patch
	${FILESDIR}/${P}.AF_UNIX.patch
	${FILESDIR}/${P}.AF_UNIX.SELinux.patch
	${FILESDIR}/${P}.vma.patch
	${FILESDIR}/${P}.CAN-2004-1016.patch
	${FILESDIR}/${P}.CAN-2004-1056.patch
	${FILESDIR}/${P}.CAN-2004-1137.patch
	${FILESDIR}/${P}.CAN-2004-1151.patch
	${FILESDIR}/${P}.shmLocking.patch"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

K_NOSETEXTRAVERSION="yes"
K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version
IUSE=""

DESCRIPTION="Full sources for the Stock Linux kernel and Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="${KERNEL_URI} http://ck.kolivas.org/patches/2.6/${KV/-ck*/}/${KV}/patch-${KV}.bz2"

KEYWORDS="~x86 ~amd64"
