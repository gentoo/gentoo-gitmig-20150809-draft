# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/tuxonice-sources/tuxonice-sources-2.6.32-r15.ebuild,v 1.1 2010/08/31 16:15:43 nelchael Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="19"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="TuxOnIce + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches/ http://www.tuxonice.net"
IUSE=""

TUXONICE_SNAPSHOT=""
TUXONICE_VERSION="3.2-rc1"
TUXONICE_TARGET="2.6.32"

if [[ -n "${TUXONICE_SNAPSHOT}" ]]; then
	TUXONICE_SRC="current-tuxonice-for-${TUXONICE_TARGET}.patch-${TUXONICE_SNAPSHOT}"
else
	TUXONICE_SRC="tuxonice-${TUXONICE_VERSION}-for-${TUXONICE_TARGET}.patch"
fi

TUXONICE_URI="http://www.tuxonice.net/downloads/all/${TUXONICE_SRC}.bz2"

UNIPATCH_LIST="${DISTDIR}/${TUXONICE_SRC}.bz2"
UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${TUXONICE_URI}"

KEYWORDS="~amd64 ~x86"

RDEPEND="${RDEPEND}
		>=sys-apps/tuxonice-userui-1.0
		>=sys-power/hibernate-script-2.0"

K_EXTRAELOG="If there are issues with this kernel, please direct any
queries to the tuxonice-users mailing list:
http://lists.tuxonice.net/mailman/listinfo/tuxonice-users/"
K_SECURITY_UNSUPPORTED="1"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
