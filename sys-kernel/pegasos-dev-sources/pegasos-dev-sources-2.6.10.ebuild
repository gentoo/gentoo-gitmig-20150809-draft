# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/pegasos-dev-sources/pegasos-dev-sources-2.6.10.ebuild,v 1.2 2005/01/09 12:44:03 dholm Exp $

ETYPE="sources"
inherit kernel-2
detect_version

# Version of gentoo patchset
GPV=10.0
GPV_SRC="mirror://gentoo/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}.tar.bz2"

KEYWORDS="ppc"
IUSE=""

UNIPATCH_LIST="${DISTDIR}/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/0000_README"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree on Pegasos computers"
SRC_URI="${KERNEL_URI} ${GPV_SRC}"
