# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.6.34-r12.ebuild,v 1.4 2010/10/21 17:42:45 jer Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="14"
inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86"
IUSE=""
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
