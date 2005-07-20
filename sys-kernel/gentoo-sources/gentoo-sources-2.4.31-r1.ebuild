# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.31-r1.ebuild,v 1.1 2005/07/20 15:13:05 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="~x86 -ppc"
IUSE=''

UNIPATCH_STRICTORDER='Y'
UNIPATCH_LIST="${DISTDIR}/${PF}.tar.bz2
	${FILESDIR}/${PN}-2.4.CAN-2004-1056.patch
	${FILESDIR}/${PN}-2.4.81106.patch"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-sources/${PF}.tar.bz2"
