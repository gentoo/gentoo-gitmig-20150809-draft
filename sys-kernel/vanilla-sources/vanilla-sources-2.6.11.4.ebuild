# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-2.6.11.4.ebuild,v 1.4 2005/03/28 15:19:07 chainsaw Exp $

detect_kpatch() {
	[ "${KV_PATCH/.[0-9]}" == "${KV_PATCH}" ] && return 1

	OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH/.[0-9]}"
	KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"
	KERNEL_PATCH_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}.bz2"
	KERNEL_PATCH="${DISTDIR}/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}.bz2"
}

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"
inherit kernel-2
detect_arch
detect_version
detect_kpatch

DESCRIPTION="Full sources for the Linux kernel"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="${KERNEL_URI} ${ARCH_URI} ${KERNEL_PATCH_URI}"
UNIPATCH_LIST="${ARCH_PATCH} ${KERNEL_PATCH}"

KEYWORDS="x86 ~ia64 ~ppc ~amd64 ~alpha ~arm"
IUSE=""
