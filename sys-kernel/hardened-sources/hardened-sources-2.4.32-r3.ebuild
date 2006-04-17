# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.32-r3.ebuild,v 1.1 2006/04/17 02:37:10 solar Exp $

IUSE="rsbac"
ETYPE="sources"
inherit kernel-2
detect_version
RDEPEND=""
HGPV=32.3
HGPV_SRC="mirror://gentoo/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"

UNIPATCH_LIST="${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README"

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC}"
KEYWORDS="~x86"

pkg_setup() {
	if use rsbac; then
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE}
		3*.patch"
	else
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE}
		4*.patch"
	fi
	:
}
pkg_postinst() {
	postinst_sources
}
