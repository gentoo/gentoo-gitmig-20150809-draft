# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.28.ebuild,v 1.3 2004/11/28 18:14:57 solar Exp $

IUSE="selinux"
ETYPE="sources"
inherit kernel-2
detect_version

HGPV=28.0
HGPV_SRC="mirror://gentoo/hardened-patches-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"

# According to the patchset numbering scheme, 31xx patches are grsec related
# while 32xx are SELinux related.

if use selinux; then
	UNIPATCH_EXCLUDE="31"
else
	UNIPATCH_EXCLUDE="32"
fi

UNIPATCH_LIST=" ${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README"

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC}"
KEYWORDS="~x86"

pkg_postinst() {
	postinst_sources
}
