# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.28-r7.ebuild,v 1.2 2005/02/19 21:21:43 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="x86 -ppc"
IUSE=''

UNIPATCH_STRICTORDER='Y'
UNIPATCH_LIST="${DISTDIR}/${PF/r7/r4}.tar.bz2
	${DISTDIR}/ck-sources-${PV}-CAN-2004-0814.patch
	${FILESDIR}/${PN}-2.4.cmdlineLeak.patch
	${FILESDIR}/${PN}-2.4.vma.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-1016.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-1056.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-1137.patch
	${FILESDIR}/${PN}-2.4.77094.patch
	${FILESDIR}/${P}.brk-locked.patch
	${FILESDIR}/${PN}-2.4.binfmt_a.out.patch
	${FILESDIR}/${PN}-2.4.77666.patch
	${FILESDIR}/${PN}-2.4.78362.patch
	${FILESDIR}/${PN}-2.4.78363.patch
	${FILESDIR}/${PN}-2.4.81106.patch
	${FILESDIR}/${P}.arpFix.patch
	${FILESDIR}/${P}.77181.patch"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-sources/${PF/r7/r4}.tar.bz2
	 http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/ck-sources-${PV}-CAN-2004-0814.patch"
