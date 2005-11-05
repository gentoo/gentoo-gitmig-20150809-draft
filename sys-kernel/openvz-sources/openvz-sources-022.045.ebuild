# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-022.045.ebuild,v 1.1 2005/11/05 20:43:32 hollow Exp $

ETYPE="sources"
CKV="2.6.8"

K_USEPV=1
K_NOSETEXTRAVERSION=1

inherit kernel-2 versionator
detect_version
detect_arch

OVZ_TREE="$(get_version_component_range 1 ${PV})"
OVZ_BUILD="$(get_version_component_range 2 ${PV})"
OVZ_STATUS="stab"
OVZ_VER="${OVZ_TREE}${OVZ_STATUS}${OVZ_BUILD}"
OVZ_COREPATCH="openvz-${OVZ_VER}-core.patch.bz2"

KEYWORDS="~x86"

DESCRIPTION="Full sources including OpenVZ patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://www.openvz.org"
SRC_URI="${KERNEL_URI} ${ARCH_URI} http://dev.gentoo.org/~hollow/openvz/patches/${OVZ_COREPATCH}"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/${OVZ_COREPATCH}"
