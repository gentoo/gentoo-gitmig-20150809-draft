# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.27-r2.ebuild,v 1.1 2004/08/31 18:03:06 scox Exp $

IUSE="selinux"
ETYPE="sources"
inherit kernel-2
detect_version

HGPV=27.1
HGPV_SRC="http://dev.gentoo.org/~scox/kernels/v2.4/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"

# According to the patchset numbering scheme, 31xx patches are grsec related
# while 32xx are SELinux related.

if use selinux; then
	UNIPATCH_EXCLUDE="31"
else
	UNIPATCH_EXCLUDE="32"
fi

UNIPATCH_LIST=" ${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2 \
				${FILESDIR}/${OKV}*.patch"

UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README"

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC}"
KEYWORDS="~x86 -ppc"

pkg_postinst() {
	postinst_sources
}
