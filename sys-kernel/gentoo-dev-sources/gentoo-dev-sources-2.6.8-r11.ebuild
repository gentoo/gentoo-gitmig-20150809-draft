# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-dev-sources/gentoo-dev-sources-2.6.8-r11.ebuild,v 1.2 2004/12/05 07:47:38 eradicator Exp $

ETYPE="sources"
AMD64_URI="ftp://ftp.x86-64.org/pub/linux/v2.6/x86_64-2.6.8-1.bz2"
inherit kernel-2
detect_version
detect_arch

#version of gentoo patchset
GPV="8.57"
GPV_SRC="mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
	mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-extras.tar.bz2"

KEYWORDS="-sparc"

UNIPATCH_LIST="${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
	       ${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-extras.tar.bz2
	       ${ARCH_PATCH}"
UNIPATCH_DOCS="${WORKDIR}/patches/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/0000_README"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GPV_SRC} ${ARCH_URI}"

DEPEND="${DEPEND} >=dev-libs/ucl-1"

IUSE="ultra1"
use ultra1 || UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1399_sparc-U1-hme-lockup.patch"
UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1321_x86_64-noiommu.patch"

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

		echo
		ewarn "SMP Support is broken in this kernel for sparc32 and sparc64."
		ewarn "If you need SMP on sparc64, please use development-sources-2.6.6"
		ewarn "or sparc-sources (2.4 kernel)."
	fi
}
