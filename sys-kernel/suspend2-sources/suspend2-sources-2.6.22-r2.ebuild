# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/suspend2-sources/suspend2-sources-2.6.22-r2.ebuild,v 1.1 2007/09/15 21:48:54 alonbl Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="6"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Software Suspend 2 + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches http://www.suspend2.net"

SUSPEND2_VERSION="2.2.10"
SUSPEND2_TARGET="2.6.22"
SUSPEND2_SRC="suspend2-${SUSPEND2_VERSION}-for-${SUSPEND2_TARGET}"
SUSPEND2_URI="http://www.tuxonice.net/downloads/all/${SUSPEND2_SRC}.patch.bz2"

UNIPATCH_LIST="${DISTDIR}/${SUSPEND2_SRC}.patch.bz2"
UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${SUSPEND2_URI}"

KEYWORDS="~amd64 ~x86"

RDEPEND="${RDEPEND}
		>=sys-apps/suspend2-userui-0.7.1
		>=sys-power/hibernate-script-1.95"

K_EXTRAEINFO="If there are issues with this kernel, please direct any
queries to the suspend2-users mailing list:
http://lists.suspend2.net/mailman/listinfo/suspend2-users/"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
