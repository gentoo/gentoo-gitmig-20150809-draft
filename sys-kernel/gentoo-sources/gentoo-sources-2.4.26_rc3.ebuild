# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.26_rc3.ebuild,v 1.1 2004/03/16 23:03:05 johnm Exp $

ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="~x86"
# the following line prevents the eclass pulling the -rc patch from the kernel mirrors
# if you choose to do that in future, you need to change SRC_URI to have ${KERNEL_URI} and drop the hard kernel mirror
UNIPATCH_LIST_DEFAULT=""
UNIPATCH_LIST="${DISTDIR}/${P}.patch.bz2"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2
	 http://dev.gentoo.org/~livewire/${P}.patch.bz2"
