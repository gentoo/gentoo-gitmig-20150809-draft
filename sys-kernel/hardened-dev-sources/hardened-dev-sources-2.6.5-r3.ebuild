# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-dev-sources/hardened-dev-sources-2.6.5-r3.ebuild,v 1.1 2004/04/19 01:40:21 method Exp $

IUSE=""
ETYPE="sources"
inherit kernel-2
detect_version

GPV=5.29
GPV_SRC="mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2"

HGPV=5.3
HGPV_SRC="mirror://gentoo/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"
UNIPATCH_EXCLUDE="1315"
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2
	${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README"

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC} ${GPV_SRC}"
#KEYWORDS="~x86 ~ppc ~sparc ~alpha -hppa"
KEYWORDS="~x86"

pkg_postinst() {
	postinst_sources
}
