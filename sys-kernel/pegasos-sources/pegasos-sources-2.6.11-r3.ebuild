# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/pegasos-sources/pegasos-sources-2.6.11-r3.ebuild,v 1.1 2005/04/06 10:02:52 dholm Exp $

ETYPE="sources"
inherit kernel-2
detect_version

# Version of gentoo patchset
GPV=11.3
GPV_SRC="mirror://gentoo/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}.tar.bz2"

KEYWORDS="ppc"
IUSE=""

UNIPATCH_LIST="${DISTDIR}/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/0000_README"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree on Pegasos computers"
SRC_URI="${KERNEL_URI} ${GPV_SRC}"
