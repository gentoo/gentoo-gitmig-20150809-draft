# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.22-r19.ebuild,v 1.1 2004/11/20 16:45:10 plasmaroo Exp $

ETYPE="sources"

inherit kernel-2
detect_version

UNIPATCH_STRICTORDER='Y'
UNIPATCH_LIST="
	${DISTDIR}/gentoo-sources-${PVR/19/5}.patch.bz2
	${FILESDIR}/${PN}-2.4.munmap.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0001.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0010.patch
	${FILESDIR}/${P}-CAN-2004-0075.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0109.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0133.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0177.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0178.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0181.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0394.patch
	${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0427.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0495.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0497.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0535.patch
	${DISTDIR}/${P}-CAN-2004-0814.patch
	${FILESDIR}/${PN}-2.4.FPULockup-53804.patch
	${FILESDIR}/${PN}-2.4.cmdlineLeak.patch
	${FILESDIR}/${PN}-2.4.XDRWrapFix.patch
	${FILESDIR}/${PN}-2.4.binfmt_elf.patch
	${FILESDIR}/${PN}-2.4.20-smbfs.patch"

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://dev.gentoo.org/~iggy/gentoo-sources-${PVR/19/5}.patch.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${P}-CAN-2004-0814.patch"
KEYWORDS="x86 -*"
IUSE=""
SLOT="${KV}"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org.
Please read the ChangeLog and associated docs for more information."
