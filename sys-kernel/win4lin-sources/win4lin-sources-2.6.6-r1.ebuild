# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/win4lin-sources/win4lin-sources-2.6.6-r1.ebuild,v 1.1 2004/06/15 18:36:02 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version

MKI_VERSION='1_3_5'
UNIPATCH_LIST="
	${DISTDIR}/mki-adapter26_${MKI_VERSION}.patch
	${DISTDIR}/Kernel-Win4Lin3-${OKV}.patch
	${FILESDIR}/${P}.FPULockup-53804.patch"

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the 2.6 of the Linux kernel with the Win4Lin patches"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	http://www.netraverse.com/member/downloads/files/mki-adapter26_1_3_5.patch
	http://www.netraverse.com/member/downloads/files/Kernel-Win4Lin3-${OKV}.patch"
KEYWORDS="x86 -*"
SLOT="${KV}"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org."
