# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/cell-sources/cell-sources-2.6.18-r6.ebuild,v 1.1 2006/11/13 19:43:51 lu_zero Exp $

ETYPE="sources"
IUSE=""
inherit kernel-2 eutils
detect_version
detect_arch

KEYWORDS="~ppc ~ppc64"
HOMEPAGE="http://kernel.org/pub/linux/kernel/people/arnd/patches/"

DESCRIPTION="Full sources including the arnd patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

ARND_VER="${PV/_/-}-arnd${PR//r}"

CELLPATCHES_URI="http://kernel.org/pub/linux/kernel/people/arnd/patches/${ARND_VER}/${ARND_VER}.diff.bz2"

SRC_URI="${KERNEL_URI} ${ARCH_URI} ${CELLPATCHES_URI}"

src_unpack() {
	kernel-2_src_unpack

	cd ${S}
	epatch ${DISTDIR}/${ARND_VER}.diff.bz2
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
