# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/suspend2-sources/suspend2-sources-2.6.20-r3.ebuild,v 1.1 2007/03/23 14:10:15 alonbl Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="4"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Software Suspend 2 + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches http://www.suspend2.net"

SUSPEND2_VERSION="2.2.9.10"
SUSPEND2_TARGET="2.6.20"
SUSPEND2_SRC="suspend2-${SUSPEND2_VERSION}-for-${SUSPEND2_TARGET}"
SUSPEND2_URI="http://www.suspend2.net/downloads/all/${SUSPEND2_SRC}.patch.bz2"

UNIPATCH_LIST="${DISTDIR}/${SUSPEND2_SRC}.patch.bz2
	${FILESDIR}/${PN}-2.6.19-vesafb.patch"
UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${SUSPEND2_URI}"

KEYWORDS="~amd64 ~x86"

RDEPEND="${RDEPEND}
		~sys-apps/suspend2-userui-0.7.0
		>=sys-power/hibernate-script-1.94"

K_EXTRAEINFO="If there are issues with this kernel, please direct any
queries to the suspend2-users mailing list:
http://lists.suspend2.net/mailman/listinfo/suspend2-users/"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
