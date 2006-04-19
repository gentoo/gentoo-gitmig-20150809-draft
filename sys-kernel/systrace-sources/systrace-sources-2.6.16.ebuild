# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/systrace-sources/systrace-sources-2.6.16.ebuild,v 1.1 2006/04/19 14:21:45 lcars Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="5"

inherit kernel-2
detect_version

HGPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}
HGPV_URI="mirror://gentoo/linux-systrace-${HGPV}.diff"
UNIPATCH_LIST="${DISTDIR}/linux-systrace-${HGPV}.diff"
DESCRIPTION="Systrace sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="~x86"
