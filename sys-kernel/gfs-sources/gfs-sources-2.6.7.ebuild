# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $

ETYPE="sources"
inherit kernel-2
detect_version

GFSV=20040626
GFSV_URI="mirror://gentoo/00001-gfs-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-${GFSV}.bz2"

KEYWORDS="~x86"

UNIPATCH_LIST="${DISTDIR}/00001-gfs-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-${GFSV}.bz2"

DESCRIPTION="Experimental sources including the global-file-system kernel patches"
SRC_URI="${KERNEL_URI} ${GFSV_URI}"

DEPEND=""

pkg_postinst() {
	postinst_sources
	echo
}
