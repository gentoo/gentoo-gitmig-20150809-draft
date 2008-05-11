# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.6.24-r2.ebuild,v 1.1 2008/05/11 07:56:17 solar Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="8"

inherit kernel-2
detect_version

HGPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-3
HGPV_URI="http://confucius.dh.bytemark.co.uk/~kerin.millar/distfiles/hardened-patches-${HGPV}.extras.tar.bz2
	mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_EXCLUDE="4200_fbcondecor-0.9.4.patch"
DESCRIPTION="Hardened kernel sources ${OKV}"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"

SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

pkg_postinst() {
	kernel-2_pkg_postinst

	ewarn
	ewarn "As of ${CATEGORY}/${PN}-2.6.24 the predefined"
	ewarn "\"Hardened [Gentoo]\" grsecurity level has been removed."
	ewarn "Two improved predefined security levels replace it:"
	ewarn "\"Hardened Gentoo [server]\" and \"Hardened Gentoo [workstation]\""
	ewarn
	ewarn "If you intend to use one of these predefined grsecurity levels,"
	ewarn "please read the help associated with the level. If you intend to"
	ewarn "import a previous kernel configuration, please review your selected"
	ewarn "grsecurity/PaX options carefully before building the kernel."
	ewarn
}
