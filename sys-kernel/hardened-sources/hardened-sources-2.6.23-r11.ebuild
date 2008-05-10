# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.6.23-r11.ebuild,v 1.3 2008/05/10 07:26:16 nixnut Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="10"

inherit kernel-2
detect_version

HGPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-9
HGPV_URI="http://confucius.dh.bytemark.co.uk/~kerin.millar/distfiles/hardened-patches-${HGPV}.extras.tar.bz2
	mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_EXCLUDE="4200_fbcondecor-0.9.4-2.6.23-rc7.patch 4205_uvesafb-0.1-rc3-2.6.23-rc3.patch 4405_alpha-sysctl-uac.patch"
DESCRIPTION="Hardened kernel sources ${OKV}"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"

SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86"

pkg_postinst() {
	kernel-2_pkg_postinst
	ewarn
	ewarn "The options selected by the \"Hardened [Gentoo]\" security level"
	ewarn "(GRKERNSEC_HARDENED) have been revised for this release. If you intend"
	ewarn "to import a previous kernel configuration which uses this level then"
	ewarn "please remember to review these changes before you build the kernel. In"
	ewarn "particular, x86 users should note that PAX_MEMORY_UDEREF is now enabled"
	ewarn "which is known not to work well in some virtualised environments. If this"
	ewarn "affects you then you should switch to the \"Custom\" security level and"
	ewarn "disable the option."
	ewarn
}
