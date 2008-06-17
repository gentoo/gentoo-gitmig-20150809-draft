# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.6.25.ebuild,v 1.1 2008/06/17 18:29:37 solar Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="5"

inherit kernel-2
detect_version

HGPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-1
HGPV_URI="http://confucius.dh.bytemark.co.uk/~kerin.millar/distfiles/hardened-patches-${HGPV}.extras.tar.bz2
	mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_EXCLUDE="2600_apple-numlock-emulation.patch 4200_fbcondecor-0.9.4.patch"
DESCRIPTION="Hardened kernel sources ${OKV}"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"

SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

pkg_postinst() {
	kernel-2_pkg_postinst

	ewarn
	ewarn "As of ${CATEGORY}/${PN}-2.6.24 the predefined \"Hardened"
	ewarn "[Gentoo]\" grsecurity level has been removed. Two improved predefined"
	ewarn "security levels replace it: \"Hardened Gentoo [server]\" and \"Hardened"
	ewarn "Gentoo [workstation]\". If you intend to use one of these predefined"
	ewarn "grsecurity levels, please read the help associated with the level. If"
	ewarn "you intend to import a previous kernel configuration, please review your"
	ewarn "selected grsecurity/PaX options carefully before building the kernel."
	ewarn
	ewarn "If you intend to use grsecurity's RBAC system then you must ensure that"
	ewarn "you are using a recent version of gradm (2.1.12 or higher). As such, it"
	ewarn "is strongly recommended that you run the following command before"
	ewarn "booting with a 2.6.25 kernel for the first time:"
	ewarn
	ewarn "emerge -na '>=sys-apps/gradm-2.1.12'"
	ewarn
}
