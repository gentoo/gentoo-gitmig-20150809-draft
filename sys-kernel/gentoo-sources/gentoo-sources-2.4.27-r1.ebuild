# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.27-r1.ebuild,v 1.3 2004/09/03 18:54:23 pvdabeel Exp $

ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="~x86 -ppc"
IUSE=""
UNIPATCH_LIST="${DISTDIR}/${PF}.tar.bz2
	${FILESDIR}/${PN}-2.4.cmdlineLeak.patch"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-sources/${PF}.tar.bz2"
