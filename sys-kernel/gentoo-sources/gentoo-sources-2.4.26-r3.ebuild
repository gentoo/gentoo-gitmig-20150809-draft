# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.26-r3.ebuild,v 1.2 2004/06/24 22:56:51 agriffis Exp $

ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="~x86"
UNIPATCH_LIST="${FILESDIR}/${PN}-2.4.CAN-2004-0495.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0535.patch
	${FILESDIR}/${PN}-2.4.FPULockup-53804.patch
	${DISTDIR}/${P}-${PR/r3/r1}.tar.bz2"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-sources/${P}-${PR/r3/r1}.tar.bz2"
