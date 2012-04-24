# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/cell-sources/cell-sources-2.6.24-r1.ebuild,v 1.3 2012/04/24 12:40:54 mgorny Exp $

ETYPE="sources"
IUSE=""
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="4"
inherit kernel-2 eutils
detect_version
detect_arch

KEYWORDS="~ppc ~ppc64"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-linux/"

DESCRIPTION="Full sources including the cell/ps3 patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
CELL_PATCH="patch-ps3-linux-${PV}-stable.${PR//r}.bz2"
CELLPATCHES_URI="mirror://kernel/linux/kernel/people/geoff/cell/ps3-linux/${CELL_PATCH}"

SRC_URI="${KERNEL_URI} ${ARCH_URI} ${CELLPATCHES_URI} ${GENPATCHES_URI}"

src_unpack() {
	kernel-2_src_unpack
	cd ${S}
	epatch "${DISTDIR}/${CELL_PATCH}"
}

pkg_postinst() {
	postinst_sources

	echo

	if [ "${ARCH}" = "sparc" ]; then
		if [ x"`cat /proc/openprom/name 2>/dev/null`" \
			 = x"'SUNW,Ultra-1'" ]; then
			einfo "For users with an Enterprise model Ultra 1 using the HME"
			einfo "network interface, please emerge the kernel using the"
			einfo "following command: USE=ultra1 emerge ${PN}"
		fi
	fi
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
