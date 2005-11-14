# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.6.14.ebuild,v 1.1 2005/11/14 20:18:19 johnm Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="3"

inherit kernel-2
detect_version
detect_arch

HGPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-1
HGPV_SRC="mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="~x86 ~ppc ~amd64"
