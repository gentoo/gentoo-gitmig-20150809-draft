# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.28.ebuild,v 1.6 2004/12/08 19:24:43 battousai Exp $

IUSE="selinux"
ETYPE="sources"
inherit kernel-2
detect_version

HGPV=28.1
HGPV_SRC="mirror://gentoo/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2 \
	  mirror://gentoo/${PN}-grsec-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-CAN-2004-0814.patch.gz \
	  mirror://gentoo/${PN}-selinux-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-CAN-2004-0814.patch.gz"

UNIPATCH_STRICTORDER="yes"

UNIPATCH_LIST=" ${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2 \
				${DISTDIR}/${PN}-grsec-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-CAN-2004-0814.patch.gz \
				${DISTDIR}/${PN}-selinux-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-CAN-2004-0814.patch.gz \
				${FILESDIR}/${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-grsec-cmdline-race.patch \
				${FILESDIR}/${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-selinux-cmdline-race.patch \
				${FILESDIR}/${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-grsec-binfmt_a.out.patch \
				${FILESDIR}/${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-selinux-binfmt_a.out.patch"

UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README"

# According to the patchset numbering scheme, 31xx patches are grsec related
# while 32xx are SELinux related.

if use selinux; then
	UNIPATCH_LIST="${UNIPATCH_LIST} 31 ${PN}-grsec ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-grsec"
else
	UNIPATCH_LIST="${UNIPATCH_LIST} 32 ${PN}-selinux ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-selinux"
fi

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC}"
KEYWORDS="~x86"

pkg_postinst() {
	postinst_sources
}
