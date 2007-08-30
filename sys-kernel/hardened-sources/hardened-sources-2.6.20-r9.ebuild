# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.6.20-r9.ebuild,v 1.1 2007/08/30 13:51:24 phreak Exp $

ETYPE="sources"

inherit kernel-2
detect_version

HGPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-7
HGPV_URI="http://dev.gentoo.org/~phreak/distfiles/${PN}/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
DESCRIPTION="Hardened kernel sources ${OKV}"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"

SRC_URI="${KERNEL_URI} ${HGPV_URI} ${ARCH_URI}"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
