# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.26-r1.ebuild,v 1.1 2004/06/10 21:40:40 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="~x86"
UNIPATCH_LIST="${DISTDIR}/${P}-${PR}.tar.bz2"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} http://dev.gentoo.org/~plasmaroo/patches/kernel/gentoo-sources/${P}-${PR}.tar.bz2"
