# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.25.ebuild,v 1.2 2004/03/21 03:12:28 livewire Exp $

ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="x86"
UNIPATCH_LIST="${DISTDIR}/${P}.patch.bz2"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} http://dev.gentoo.org/~livewire/${P}.patch.bz2"
