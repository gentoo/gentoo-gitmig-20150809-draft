# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/win4lin-sources/win4lin-sources-2.6.9-r7.ebuild,v 1.1 2005/03/25 19:40:07 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version

MKI_VERSION='1_3_8'
UNIPATCH_LIST="
	${DISTDIR}/Kernel-Win4Lin3-${OKV}.patch
	${DISTDIR}/mki-adapter26_${MKI_VERSION}.patch:1
	${FILESDIR}/${P}.binfmt_elf.patch
	${FILESDIR}/${P}.binfmt_a.out.patch
	${FILESDIR}/${P}.smbfs.patch
	${FILESDIR}/${P}.AF_UNIX.patch
	${FILESDIR}/${P}.AF_UNIX.SELinux.patch
	${FILESDIR}/${P}.CAN-2004-1151.patch
	${FILESDIR}/${P}.vma.patch
	${FILESDIR}/${P}.CAN-2004-1016.patch
	${FILESDIR}/${P}.CAN-2004-1056.patch
	${FILESDIR}/${P}.CAN-2004-1137.patch
	${FILESDIR}/${P}.CAN-2004-1151.patch
	${FILESDIR}/${P}.shmLocking.patch
	${FILESDIR}/${P}.75963.patch
	${FILESDIR}/${P}.brk-locked.patch
	${FILESDIR}/${P}.77094.patch
	${FILESDIR}/${P}.74070.patch
	${FILESDIR}/${P}.77666.patch
	${FILESDIR}/${P}.77923.patch
	${FILESDIR}/${P}.78362.patch
	${FILESDIR}/${P}.78363.patch
	${FILESDIR}/${P}.81106.patch
	${FILESDIR}/${P}.82141.patch"

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the 2.6 of the Linux kernel with the Win4Lin patches"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	ftp://ftp.netraverse.com/pub/testing/kernel/patches/mki-adapter26_${MKI_VERSION}.patch
	ftp://ftp.netraverse.com/pub/testing/kernel/patches/Kernel-Win4Lin3-${OKV}.patch"

# Best to keep "~x86" until Win4Lin-5.1.10 is in the tree and stable;
# bug #55587.
KEYWORDS="~x86 -*"
SLOT="${KV}"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org."
