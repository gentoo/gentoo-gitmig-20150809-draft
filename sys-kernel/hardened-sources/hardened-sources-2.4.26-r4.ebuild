# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.26-r4.ebuild,v 1.1 2004/08/04 19:59:24 scox Exp $

IUSE="selinux"
ETYPE="sources"
inherit kernel-2
detect_version

HGPV=26.0
HGPV_SRC="http://dev.gentoo.org/~scox/kernels/v2.4/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"

# According to the patchset numbering scheme, 12xx patches are grsec related
# while 13xx are SELinux related.

if use selinux; then
	UNIPATCH_EXCLUDE="12"
else
	UNIPATCH_EXCLUDE="13"
fi

UNIPATCH_LIST="${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2
				${FILESDIR}/${OKV}*.patch"
UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README"

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC}"
KEYWORDS="x86 -ppc"

pkg_postinst() {
	postinst_sources
}
