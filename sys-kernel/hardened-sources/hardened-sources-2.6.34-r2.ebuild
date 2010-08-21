# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.6.34-r2.ebuild,v 1.1 2010/08/21 11:57:11 blueness Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="8"

inherit kernel-2
detect_version

HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-3"
HGPV_URI="mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"
SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"

# Note: 4420_grsecurity-2.2.0-2.6.34.4-201008131840.patch includes
# 1800_page-table-unmap-for-stack-guard-fix.patch so we don't want
# to apply it twice: see https://bugzilla.kernel.org/show_bug.cgi?id=16588
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_EXCLUDE="1800_page-table-unmap-for-stack-guard-fix.patch 4200_fbcondecor-0.9.6.patch"

DESCRIPTION="Hardened kernel sources (kernel series ${KV_MAJOR}.${KV_MINOR})"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"
IUSE=""

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

pkg_postinst() {
	kernel-2_pkg_postinst

	local GRADM_COMPAT="sys-apps/gradm-2.2.0*"

	ewarn
	ewarn "Hardened Gentoo provides four different predefined grsecurity level:"
	ewarn "[server], [server no rbac] [workstation] [workstation no rbac]"
	ewarn
	ewarn "Those who intend to use one of these predefined grsecurity levels"
	ewarn "should read the help associated with the level.  Users importing a"
	ewarn "kernel configuration from a kernel prior to ${PN}-2.6.32,"
	ewarn "should review their selected grsecurity/PaX options carefully."
	ewarn
	ewarn "Users of grsecurity's RBAC system must ensure they are using"
	ewarn "${GRADM_COMPAT}, which is compatible with ${PF}."
	ewarn "It is strongly recommended that the following command is issued"
	ewarn "prior to booting a ${PF} kernel for the first time:"
	ewarn
	ewarn "emerge -na =${GRADM_COMPAT}"
	ewarn
}
