# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xbox-sources/xbox-sources-2.4.26-r4.ebuild,v 1.1 2004/08/05 12:17:09 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version

XBOX_PATCH="xbox-sources-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-${PR/r4/r3}.patch.bz2"

SRC_URI="${KERNEL_URI}
	mirror://gentoo/${XBOX_PATCH}
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch"
DESCRIPTION="Full sources for the Xbox Linux kernel"
HOMEPAGE="http://www.xbox-linux.org"
K_NOSETEXTRAVERSION="don't_set_it"
KEYWORDS="~x86 -*"

UNIPATCH_LIST="
	${DISTDIR}/${XBOX_PATCH}
	${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch
	${FILESDIR}/${P}.CAN-2004-0394.patch
	${FILESDIR}/${P}.CAN-2004-0495.patch
	${FILESDIR}/${PN}.CAN-2004-0497.patch
	${FILESDIR}/${P}.CAN-2004-0535.patch
	${FILESDIR}/${P}.FPULockup-53804.patch"
