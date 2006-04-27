# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.6.16-r5.ebuild,v 1.1 2006/04/27 14:52:28 johnm Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="6"

inherit kernel-2
detect_version

HGPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-5
HGPV_URI="mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~sparc"
