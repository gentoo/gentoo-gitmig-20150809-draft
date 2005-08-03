# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openmosix-sources/openmosix-sources-2.6.12.577.ebuild,v 1.1 2005/08/03 14:04:39 voxus Exp $

ETYPE="sources"

# stripping oM's revision
inherit versionator eutils

OMR="$(get_version_component_range 4 ${PV})"
OKV="$(get_version_component_range 1-3 ${OKV})"
EXTRAVERSION="-openmosix-r${OMR}"

inherit kernel-2

detect_version
detect_arch

KV_FULL=${OKV}-openmosix-r${OMR}

# version of gentoo patchset
GPV="12-11"
GPV_SRC="mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}.${GPV}.base.tar.bz2
	mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}.${GPV}.extras.tar.bz2"

KEYWORDS="~amd64 ~x86"

HOMEPAGE="http://openmosix.snarc.org/"

UNIPATCH_LIST="${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}.${GPV}.base.tar.bz2
			${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}.${GPV}.extras.tar.bz2
			${DISTDIR}/patch-${OKV}-om-r${OMR}.bz2"

UNIPATCH_STRICTORDER="genpatches-${KV_MAJOR}.${KV_MINOR}.${GPV}.base.tar.bz2
			${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}.${GPV}.extras.tar.bz2
			${DISTDIR}/patch-${OKV}-om-r${OMR}.bz2"

UNIPATCH_DOCS="${WORKDIR}/patches/genpatches-${KV_MAJOR}.${KV_MINOR}.${GPV}/0000_README"

OM_SRC="http://openmosix.snarc.org/files/releases/2.6/patch-${OKV}-om-r${OMR}.bz2"

DESCRIPTION="Full sources for the Gentoo openMosix Linux kernel ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GPV_SRC} ${ARCH_URI} ${OM_SRC}"

src_unpack() {
	kernel-2_src_unpack

	epatch ${FILESDIR}/${PN}-extraversion.patch
}

pkg_postinst() {
	postinst_sources

	echo

	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
