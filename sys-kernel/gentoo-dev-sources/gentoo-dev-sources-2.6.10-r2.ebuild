# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-dev-sources/gentoo-dev-sources-2.6.10-r2.ebuild,v 1.3 2005/01/04 09:29:18 eradicator Exp $

ETYPE="sources"
inherit kernel-2
detect_version
detect_arch

#version of gentoo patchset
GPV="10.02"
GPV_SRC="mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
	mirror://gentoo/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-extras.tar.bz2"

KEYWORDS="~amd64 ~x86 ~sparc"

HOMEPAGE="http://dev.gentoo.org/~dsd/gentoo-dev-sources"

UNIPATCH_LIST="${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-base.tar.bz2
	       ${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}-extras.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/genpatches-${KV_MAJOR}.${KV_MINOR}-${GPV}/0000_README"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GPV_SRC} ${ARCH_URI}"

DEPEND="${DEPEND} >=dev-libs/ucl-1"

IUSE="ultra1"

pkg_setup() {
	if use sparc; then
		# hme lockup hack on ultra1
		use ultra1 || UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1399_sparc-U1-hme-lockup.patch"

		# Don't overpatch sparc (i.e. keep ciaranm happy) ;p
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE}
		                  1315_alpha-sysctl-uac.patch
		                  2500_vesafb-tng-0.9-rc5.patch
		                  2700_ppc-pegasos-2.6.6.patch
		                  4300_evms-dm-bbr.patch
		                  4305_dm-multipath.patch
		                  4306_dm-mp-version.patch
		                  4307_dm-mp-hw.patch
		                  4310_ich7-support.patch
		                  4500_fbsplash-0.9.1.patch
		                  4905_speakup-20041020.patch"
	fi
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
