# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/aa-sources/aa-sources-2.6.5-r5.ebuild,v 1.13 2004/10/21 18:10:10 plasmaroo Exp $

ETYPE="sources"
K_NOUSENAME="yes"

inherit kernel-2
detect_version
KV="${KV/-r/-aa}"

UNIPATCH_LIST="
	${DISTDIR}/${KV}.bz2
	${FILESDIR}/${P}.CAN-2004-0075.patch
	${FILESDIR}/${P}.CAN-2004-0228.patch
	${FILESDIR}/${P}.CAN-2004-0229.patch
	${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch
	${FILESDIR}/${P}.CAN-2004-0427.patch
	${FILESDIR}/${PN}.CAN-2004-0497.patch
	${FILESDIR}/${P}.FPULockup-53804.patch
	${FILESDIR}/${P}.IPTables-RDoS.patch
	${FILESDIR}/${P}.ProcPerms.patch
	${FILESDIR}/${P}.CAN-2004-0596.patch
	${FILESDIR}/${P}.CAN-2004-0495-0496.patch
	${FILESDIR}/${P}.cmdlineLeak.patch
	${FILESDIR}/${P}.CAN-2004-0816.patch"

K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

DESCRIPTION="Full sources for Andrea Arcangeli's Linux kernel"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/"
SRC_URI="${KERNEL_URI} mirror://kernel/linux/kernel/people/andrea/kernels/v2.6/${KV}.bz2
	 http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch"

KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE=""
