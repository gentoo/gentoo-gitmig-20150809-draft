# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/suspend2-sources/suspend2-sources-2.6.12-r6.ebuild,v 1.1 2005/08/21 14:54:39 brix Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="13"

inherit eutils kernel-2
detect_version
detect_arch

DESCRIPTION="Software Suspend 2 + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches http://www.suspend2.net"

SUSPEND2_VERSION="2.1.9.9"
SUSPEND2_TARGET="${PV}"
SUSPEND2_SRC="software-suspend-${SUSPEND2_VERSION}-for-${SUSPEND2_TARGET}"
SUSPEND2_URI="http://www.suspend2.net/downloads/all/${SUSPEND2_SRC}.tar.bz2"

UNIPATCH_LIST="${FILESDIR}/4306_dm-bbr-create_workqueue.patch
${FILESDIR}/linux-2.6.12-vesafb-tng-suspend2.patch
${FILESDIR}/linux-2.6.12-try_to_freeze.patch
${FILESDIR}/linux-2.6.12-skge-pm_message_t.patch"
UNIPATCH_STRICTORDER="yes"
UNIPATCH_DOCS="${WORKDIR}/${SUSPEND2_SRC}/Changelog
${WORKDIR}/${SUSPEND2_SRC}/ToDo"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${SUSPEND2_URI}"

KEYWORDS="~x86"

IUSE="ultra1"
RDEPEND="${RDEPEND}
		>=sys-apps/suspend2-userui-0.5.0
		>=sys-power/hibernate-script-1.09"

K_EXTRAEINFO="If there are issues with this kernel, please direct any
queries to the suspend2-devel mailing list:
http://lists.suspend2.net/cgi-bin/mailman/listinfo/suspend2-devel"

pkg_setup() {
	if use sparc; then
		# hme lockup hack on ultra1
		use ultra1 || UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1399_sparc-U1-hme-lockup.patch"
	fi
}

src_unpack() {
	kernel-2_src_unpack

	cd ${WORKDIR}
	unpack ${SUSPEND2_SRC}.tar.bz2

	cd ${S}
	EPATCH_EXCLUDE="apply Changelog unapply ToDo" \
	EPATCH_FORCE="yes" \
	EPATCH_SUFFIX="" \
	EPATCH_OPTS="-p1" \
	epatch ${WORKDIR}/${SUSPEND2_SRC}
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
