# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/win4lin-sources/win4lin-sources-2.6.7-r4.ebuild,v 1.1 2004/08/05 12:03:02 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version

MKI_VERSION='1_3_6'
UNIPATCH_LIST="
	${DISTDIR}/mki-adapter26_${MKI_VERSION}.patch
	${DISTDIR}/Kernel-Win4Lin3-${OKV}.patch
	${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch
	${FILESDIR}/${PN}.CAN-2004-0497.patch
	${FILESDIR}/${PN}-2.6.CAN-2004-0596.patch
	${FILESDIR}/${PN}-2.6.IPTables-RDoS.patch
	${FILESDIR}/${PN}-2.6.ProcPerms.patch"

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the 2.6 of the Linux kernel with the Win4Lin patches"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	http://www.netraverse.com/member/downloads/files/mki-adapter26_${MKI_VERSION}.patch
	http://www.netraverse.com/member/downloads/files/Kernel-Win4Lin3-${OKV}.patch
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch"
KEYWORDS="x86 -*"
SLOT="${KV}"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org."
