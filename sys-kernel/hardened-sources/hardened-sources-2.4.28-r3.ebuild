# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.28-r3.ebuild,v 1.1 2005/01/18 00:21:14 tocharian Exp $

IUSE="selinux"
ETYPE="sources"
inherit kernel-2
detect_version

HGPV=28.4
HGPV_SRC="http://dev.gentoo.org/~tocharian/kernels/${PN}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"

UNIPATCH_LIST="${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README"

# According to the patchset numbering scheme, 31xx patches are grsec related
# while 32xx are SELinux related.

if use selinux; then
	UNIPATCH_LIST="${UNIPATCH_LIST} 31"
else
	UNIPATCH_LIST="${UNIPATCH_LIST} 32"
fi

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC}"
KEYWORDS="~x86"

pkg_postinst() {
	postinst_sources
}
