# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources/ppc-sources-2.4.26.ebuild,v 1.1 2004/05/30 22:57:34 pvdabeel Exp $

ETYPE="sources"
inherit kernel-2
detect_version

# Version of gentoo patchset
GPV=26.1
GPV_SRC="mirror://gentoo/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2"

KEYWORDS="-* ppc"

UNIPATCH_LIST="${DISTDIR}/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/0000_README"

DESCRIPTION="Full sources including the Pegasos patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GPV_SRC}"

DEPEND="${DEPEND}"
