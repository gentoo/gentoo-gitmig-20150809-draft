# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/pegasos-sources/pegasos-sources-2.4.26-r3.ebuild,v 1.1 2004/07/21 09:12:24 dholm Exp $

ETYPE="sources"
inherit kernel-2
detect_version

# Version of gentoo patchset
GPV=26.1
GPV_SRC="mirror://gentoo/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2"

KEYWORDS="-* ppc"
IUSE=""

UNIPATCH_LIST="${DISTDIR}/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
	${FILESDIR}/${P}.CAN-2004-0394.patch
	${FILESDIR}/${P}.CAN-2004-0495.patch
	${FILESDIR}/${P}.CAN-2004-0497.patch
	${FILESDIR}/${P}.CAN-2004-0535.patch"
UNIPATCH_DOCS="${WORKDIR}/patches/pegpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/0000_README"

DESCRIPTION="Full sources including the Pegasos patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GPV_SRC}"

DEPEND="${DEPEND}"
