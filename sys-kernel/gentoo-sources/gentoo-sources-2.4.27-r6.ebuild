# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.27-r6.ebuild,v 1.1 2004/12/24 18:23:50 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="~x86 -ppc"
IUSE=''

UNIPATCH_STRICTORDER='Y'
UNIPATCH_LIST="${DISTDIR}/${PF/r6/r1}.tar.bz2
	${DISTDIR}/${PN}-2.4.22-CAN-2004-0814.patch
	${FILESDIR}/${PN}-2.4.cmdlineLeak.patch
	${FILESDIR}/${PN}-2.4.XDRWrapFix.patch
	${FILESDIR}/${PN}-2.4.binfmt_elf.patch
	${FILESDIR}/${PN}-2.4.smbfs.patch
	${FILESDIR}/${PN}-2.4.AF_UNIX.patch
	${FILESDIR}/${PN}-2.4.binfmt_a.out.patch
	${FILESDIR}/${PN}-2.4.vma.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-1016.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-1056.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-1137.patch"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-sources/${PF/r6/r1}.tar.bz2
	 http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${PN}-2.4.22-CAN-2004-0814.patch"

