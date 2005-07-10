# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openblocks-sources/openblocks-sources-2.4.28.ebuild,v 1.1 2005/07/10 01:12:45 matsuu Exp $

ETYPE="sources"
inherit kernel-2
detect_version

# Version of obs patchset
OPV="28.01"
OPV_SRC="http://dev.gentoo.org/~matsuu/obs/obspatches-${KV_MAJOR}.${KV_MINOR}-${OPV}.tar.bz2"

KEYWORDS="~ppc"
IUSE=""

HOMEPAGE="http://dev.gentoo.org/~matsuu/obs/"
UNIPATCH_LIST="${DISTDIR}/obspatches-${KV_MAJOR}.${KV_MINOR}-${OPV}.tar.bz2"

DESCRIPTION="Full sources including the OpenBlockS patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${OPV_SRC}"
