# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-dev-sources/gentoo-dev-sources-2.6.7-r7.ebuild,v 1.2 2004/07/15 03:48:34 agriffis Exp $

ETYPE="sources"
inherit kernel-2
detect_version

#version of gentoo patchset
GPV=7.39
GPV_SRC="mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
	mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-extras.tar.bz2"

KEYWORDS="x86 amd64 ppc"
IUSE=""

UNIPATCH_LIST="${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
	       ${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-extras.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/0000_README"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GPV_SRC}"

DEPEND="${DEPEND} >=dev-libs/ucl-1"

pkg_postinst() {
	postinst_sources

	echo
}
