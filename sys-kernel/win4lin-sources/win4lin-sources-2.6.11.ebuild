# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/win4lin-sources/win4lin-sources-2.6.11.ebuild,v 1.1 2005/05/17 12:15:40 dsd Exp $

ETYPE="sources"
inherit kernel-2
detect_version

GPV="11.12"
GPV_SRC="mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2"

MKI_VERSION='1_3_12'
W4L_VERSION='2.6.11.5'
UNIPATCH_LIST="
	${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
	${DISTDIR}/Kernel-Win4Lin3-${W4L_VERSION}.patch
	${DISTDIR}/mki-adapter26_${MKI_VERSION}.patch:1"

DESCRIPTION="Full sources for the 2.6 of the Linux kernel with the Win4Lin patches"
SRC_URI="${KERNEL_URI} ${GPV_SRC}
	http://www.netraverse.com/member/downloads/files/mki-adapter26_${MKI_VERSION}.patch
	http://www.netraverse.com/member/downloads/files/Kernel-Win4Lin3-${W4L_VERSION}.patch"

# Best to keep "~x86" until Win4Lin-5.1.10 is in the tree and stable;
# bug #55587.
KEYWORDS="~x86 -*"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to kernel@gentoo.org."
