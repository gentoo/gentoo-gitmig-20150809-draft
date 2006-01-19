# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/suspend2-sources/suspend2-sources-2.6.15-r3.ebuild,v 1.1 2006/01/19 14:26:50 brix Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="3"

inherit eutils kernel-2
detect_version
detect_arch

DESCRIPTION="Software Suspend 2 + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches http://www.suspend2.net"

SUSPEND2_VERSION="2.2-rc16"
SUSPEND2_TARGET="2.6.15.1"
SUSPEND2_SRC="suspend2-${SUSPEND2_VERSION}-for-${SUSPEND2_TARGET}"
SUSPEND2_URI="http://www.suspend2.net/downloads/all/${SUSPEND2_SRC}.tar.bz2"

UNIPATCH_LIST="${DISTDIR}/${SUSPEND2_SRC}.tar.bz2
${FILESDIR}/suspend2-2.2-rc16-amd64-is-ram.patch
${FILESDIR}/suspend2-2.2-rc16-debug-rodata-define.patch
${FILESDIR}/suspend2-2.2-rc16-remove-block-dump.patch
${FILESDIR}/suspend2-2.2-rc16-swapwriter-selects-swap.patch
${FILESDIR}/suspend2-2.2-rc16-amd64-temporary-mapping.patch
${FILESDIR}/suspend2-2.2-rc16-clean-prepare-image-result-testing.patch
${FILESDIR}/suspend2-2.2-rc16-debug-writing-header.patch
${FILESDIR}/suspend2-2.2-rc16-filewriter-fix.patch
${FILESDIR}/suspend2-2.2-rc16-write-header-chunk-finish.patch"
UNIPATCH_STRICTORDER="yes"
UNIPATCH_DOCS="${WORKDIR}/patches/${SUSPEND2_SRC}/Changelog.txt
${WORKDIR}/patches/${SUSPEND2_SRC}/ToDo"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${SUSPEND2_URI}"

KEYWORDS="~x86"

IUSE="ultra1"
RDEPEND="${RDEPEND}
		>=sys-apps/suspend2-userui-0.6.1
		>=sys-power/hibernate-script-1.12"

K_EXTRAEINFO="If there are issues with this kernel, please direct any
queries to the suspend2-users mailing list:
http://lists.suspend2.net/mailman/listinfo/suspend2-users/"

pkg_setup() {
	if use sparc; then
		# hme lockup hack on ultra1
		use ultra1 || UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1399_sparc-U1-hme-lockup.patch"
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
}
