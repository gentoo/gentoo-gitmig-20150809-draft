# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.4.28-r1.ebuild,v 1.2 2005/01/07 15:23:58 dsd Exp $

ETYPE="sources"

inherit kernel-2
detect_version

# CKV=con kolivas release version
CKV="1"

KEYWORDS="~x86"
IUSE=""
UNIPATCH_STRICTORDER="Y"
UNIPATCH_LIST="${DISTDIR}/patch-${PV}-lck${CKV}.bz2
	${DISTDIR}/${PN}-2.4.27-CAN-2004-0814.patch
	${FILESDIR}/${P}.cmdlineLeak.patch
	${FILESDIR}/${P}.binfmt_a.out.patch
	${FILESDIR}/${P}.vma.patch
	${FILESDIR}/${P}.CAN-2004-1016.patch
	${FILESDIR}/${P}.CAN-2004-1056.patch
	${FILESDIR}/${P}.CAN-2004-1137.patch
	${FILESDIR}/${P}.compileFix.patch"

DESCRIPTION="Full sources for the Stock Linux kernel Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="${KERNEL_URI}
	http://www.plumlocosoft.com/kernel/patches/2.4/${PV}/${PV}-lck${CKV}/patch-${PV}-lck${CKV}.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${PN}-2.4.27-CAN-2004-0814.patch"
