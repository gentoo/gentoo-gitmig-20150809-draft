# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.4.28-r3.ebuild,v 1.1 2005/02/15 21:50:55 plasmaroo Exp $

ETYPE="sources"

inherit kernel-2
detect_version

# CKV=con kolivas release version
CKV="1"

KEYWORDS="~x86"
IUSE=""
UNIPATCH_STRICTORDER="Y"
UNIPATCH_LIST="${DISTDIR}/patch-${PV}-lck${CKV}.bz2
	${FILESDIR}/${P}.cmdlineLeak.patch
	${FILESDIR}/${P}.CAN-2004-1016.patch
	${FILESDIR}/${P}.CAN-2004-1056.patch
	${FILESDIR}/${P}.CAN-2004-1137.patch
	${FILESDIR}/${P}.compileFix.patch
	${FILESDIR}/${P}.binfmt_a.out.patch
	${FILESDIR}/${P}.vma.patch
	${FILESDIR}/${P}.brk-locked.patch
	${DISTDIR}/${P}-CAN-2004-0814.patch
	${FILESDIR}/${P}.77094.patch
	${FILESDIR}/${P}.77666.patch
	${FILESDIR}/${P}.78362.patch
	${FILESDIR}/${P}.78363.patch
	${FILESDIR}/${PN}-81106.patch"

DESCRIPTION="Full sources for the Stock Linux kernel Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="${KERNEL_URI}
	http://www.plumlocosoft.com/kernel/patches/2.4/${PV}/${PV}-lck${CKV}/patch-${PV}-lck${CKV}.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-2.4.28-CAN-2004-0814.patch"
