# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.22-r9.ebuild,v 1.1 2004/04/17 10:59:15 plasmaroo Exp $

ETYPE="sources"
UNIPATCH_LIST="
	${FILESDIR}/${PN}-2.4.munmap.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0001.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0010.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0109.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0177.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0178.patch
	${DISTDIR}/gentoo-sources-${PVR/9/5}.patch.bz2"

inherit kernel-2
detect_version

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://dev.gentoo.org/~iggy/gentoo-sources-${PVR/9/5}.patch.bz2"
KEYWORDS="x86 -*"
SLOT="${KV}"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org.
Please read the ChangeLog and associated docs for more information."
