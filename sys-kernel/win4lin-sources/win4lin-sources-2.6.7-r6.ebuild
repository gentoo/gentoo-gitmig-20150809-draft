# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/win4lin-sources/win4lin-sources-2.6.7-r6.ebuild,v 1.1 2004/10/21 18:33:36 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version

MKI_VERSION='1_3_6'
UNIPATCH_LIST="
	${DISTDIR}/Kernel-Win4Lin3-${OKV}.patch
	${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch
	${DISTDIR}/mki-adapter26_${MKI_VERSION}.patch:1
	${FILESDIR}/${PN}.CAN-2004-0497.patch
	${FILESDIR}/${PN}-2.6.CAN-2004-0596.patch
	${FILESDIR}/${PN}-2.6.IPTables-RDoS.patch
	${FILESDIR}/${PN}-2.6.ProcPerms.patch
	${FILESDIR}/${PN}-2.6.cmdlineLeak.patch
	${FILESDIR}/${PN}-2.6.CAN-2004-0816.patch"

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the 2.6 of the Linux kernel with the Win4Lin patches"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	http://www.netraverse.com/member/downloads/files/mki-adapter26_${MKI_VERSION}.patch
	http://www.netraverse.com/member/downloads/files/Kernel-Win4Lin3-${OKV}.patch
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch"

# Best to keep "~x86" until Win4Lin-5.1.10 is in the tree and stable;
# bug #55587.
KEYWORDS="~x86 -*"
SLOT="${KV}"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org."
