# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-dev-sources/gentoo-dev-sources-2.6.9.ebuild,v 1.2 2004/10/20 14:38:42 dsd Exp $

ETYPE="sources"
inherit kernel-2
detect_version
detect_arch

#version of gentoo patchset
GPV="9.01"
GPV_SRC="mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
	mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-extras.tar.bz2"

KEYWORDS="~x86 -amd64 ~ppc ~ppc64 ~ia64 ~alpha"

UNIPATCH_LIST="${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
	       ${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-extras.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/0000_README"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GPV_SRC} ${ARCH_URI}"

DEPEND="${DEPEND} >=dev-libs/ucl-1"

IUSE="ultra1"
use ultra1 || UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1399_sparc-U1-hme-lockup.patch"

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
}
