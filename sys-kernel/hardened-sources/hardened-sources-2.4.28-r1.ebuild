# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.28-r1.ebuild,v 1.4 2005/01/24 01:56:13 solar Exp $

IUSE="selinux"
ETYPE="sources"
inherit kernel-2
detect_version
RDEPEND=""
HGPV=28.2
HGPV_SRC="mirror://gentoo/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"

UNIPATCH_LIST="${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README"

# According to the patchset numbering scheme, 31xx and 41xx patches are grsec related
# while 32xx and 42xx are SELinux related.

if use selinux; then
	UNIPATCH_LIST="${UNIPATCH_LIST} 31 41"
else
	UNIPATCH_LIST="${UNIPATCH_LIST} 32 42"
fi

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC}"
KEYWORDS="x86"

pkg_postinst() {
	postinst_sources
}
