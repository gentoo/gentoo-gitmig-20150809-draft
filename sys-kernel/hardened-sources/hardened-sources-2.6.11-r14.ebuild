# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.6.11-r14.ebuild,v 1.1 2005/06/14 22:54:24 johnm Exp $

ETYPE="sources"
inherit kernel-2
detect_version

GPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-${PR//r}
HGPV=${GPV}
GPV_SRC="mirror://gentoo/genpatches-${GPV}.base.tar.bz2"
HGPV_SRC="mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"

UNIPATCH_LIST="${DISTDIR}/genpatches-${GPV}.base.tar.bz2
			   ${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC} ${GPV_SRC}"
KEYWORDS="x86 ppc amd64"
