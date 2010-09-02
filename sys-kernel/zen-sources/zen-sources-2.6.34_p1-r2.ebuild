# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/zen-sources/zen-sources-2.6.34_p1-r2.ebuild,v 1.2 2010/09/02 07:52:12 wired Exp $

EAPI="2"

COMPRESSTYPE=".lzma"
K_USEPV="yes"
UNIPATCH_STRICTORDER="yes"
K_SECURITY_UNSUPPORTED="1"

CKV="${PV/_p[0-9]*}"
ETYPE="sources"
inherit kernel-2
detect_version
K_NOSETEXTRAVERSION="don't_set_it"

DESCRIPTION="The Zen Kernel Sources v2.6"
HOMEPAGE="http://zen-kernel.org"

ZEN_PATCHSET="${PV/*_p}"
ZEN_KERNEL="${PV/_p[0-9]*}"
ZEN_KERNEL="${ZEN_KERNEL/_/-}"
ZEN_FILE="${ZEN_KERNEL}-zen${ZEN_PATCHSET}.patch${COMPRESSTYPE}"
ZEN_URI="http://downloads.zen-kernel.org/$(get_version_component_range 1-3)/${ZEN_FILE}"
ZEN_PATCHES="
	http://algo.ing.unimo.it/people/paolo/disk_sched/patches/2.6.34-zen1/0001-block-prepare-I-O-context-code-for-BFQ.patch
	http://algo.ing.unimo.it/people/paolo/disk_sched/patches/2.6.34-zen1/0002-block-add-cgroups-kconfig-and-build-bits-for-BFQ.patch
	http://algo.ing.unimo.it/people/paolo/disk_sched/patches/2.6.34-zen1/0003-block-introduce-the-BFQ-I-O-scheduler.patch -> 0003-block-introduce-the-BFQ-I-O-scheduler-r1.patch
"
SRC_URI="${KERNEL_URI} ${ZEN_URI} bfq? ( ${ZEN_PATCHES} )"

KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"
IUSE="bfq"

DEPEND="|| ( app-arch/xz-utils app-arch/lzma-utils )"
RDEPEND=""

KV_FULL="${PVR/_p/-zen}"
S="${WORKDIR}"/linux-"${KV_FULL}"

pkg_setup(){
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the Zen developers directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn
	ebeep 8
	kernel-2_pkg_setup
}

src_prepare(){
	epatch "${DISTDIR}"/"${ZEN_FILE}"
	if use bfq; then
		EPATCH_OPTS="-p1"
		epatch "${DISTDIR}/0001-block-prepare-I-O-context-code-for-BFQ.patch"
		epatch "${DISTDIR}/0002-block-add-cgroups-kconfig-and-build-bits-for-BFQ.patch"
		epatch "${DISTDIR}/0003-block-introduce-the-BFQ-I-O-scheduler-r1.patch"
	fi
}

K_EXTRAEINFO="For more info on zen-sources and details on how to report problems, see: \
${HOMEPAGE}. You may also visit #zen-sources on irc.rizon.net"
