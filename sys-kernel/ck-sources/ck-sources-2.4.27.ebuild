# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.4.27.ebuild,v 1.1 2004/10/13 21:12:28 dsd Exp $

ETYPE="sources"
inherit kernel-2
detect_version

# CKV=con kolivas release version
CKV="1"

KEYWORDS="~x86 -ppc"
IUSE=""
UNIPATCH_LIST="${DISTDIR}/patch-${PV}-lck${CKV}.bz2
	${FILESDIR}/${P}.CAN-2004-0394.patch
	${FILESDIR}/${P}.cmdlineLeak.patch"

DESCRIPTION="Full sources for the Stock Linux kernel Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="${KERNEL_URI}
	http://www.plumlocosoft.com/kernel/patches/2.4/${PV}/${PV}-lck${CKV}/patch-${PV}-lck${CKV}.bz2"
