# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-dev-sources/hardened-dev-sources-2.6.10-r2.ebuild,v 1.2 2005/01/17 04:21:08 absinthe Exp $

IUSE=""
ETYPE="sources"
inherit kernel-2
detect_version

HGPV=10.2
HGPV_SRC="http://dev.gentoo.org/~tocharian/kernels/${PN}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README \
			   ${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0001_README-AC9"

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC}"
KEYWORDS="~x86 ~amd64"

pkg_postinst() {
	postinst_sources
}
