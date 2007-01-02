# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openblocks-sources/openblocks-sources-2.6.11.12.ebuild,v 1.2 2007/01/02 01:47:35 dsd Exp $

ETYPE="sources"
K_SECURITY_UNSUPPORTED="1"
inherit kernel-2
detect_version

# Version of obs patchset
OPV="11.01"
OPV_SRC="http://dev.gentoo.org/~matsuu/obs/obspatches-${KV_MAJOR}.${KV_MINOR}-${OPV}.tar.bz2"

KEYWORDS="~ppc"
IUSE=""

HOMEPAGE="http://dev.gentoo.org/~matsuu/obs/"
UNIPATCH_LIST="${DISTDIR}/obspatches-${KV_MAJOR}.${KV_MINOR}-${OPV}.tar.bz2"

DESCRIPTION="Full sources including the OpenBlockS patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${OPV_SRC}"
