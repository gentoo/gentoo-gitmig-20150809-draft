# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/aa-sources/aa-sources-2.6.5-r5.ebuild,v 1.9 2004/07/21 10:23:02 plasmaroo Exp $

UNIPATCH_LIST="${DISTDIR}/${KV}.bz2 ${FILESDIR}/${P}.CAN-2004-0075.patch ${FILESDIR}/${P}.CAN-2004-0228.patch ${FILESDIR}/${P}.CAN-2004-0229.patch ${FILESDIR}/${P}.CAN-2004-0427.patch ${FILESDIR}/${PN}.CAN-2004-0497.patch ${FILESDIR}/${P}.FPULockup-53804.patch ${FILESDIR}/${P}.IPTables-RDoS.patch ${FILESDIR}/${P}.ProcPerms.patch ${FILESDIR}/${P}.CAN-2004-0596.patch"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for Andrea Arcangeli's Linux kernel"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/"
SRC_URI="${KERNEL_URI} mirror://kernel/linux/kernel/people/andrea/kernels/v2.6/${KV}.bz2"

KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE=""
