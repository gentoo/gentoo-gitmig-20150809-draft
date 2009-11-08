# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

COMPRESSTYPE=".lzma"
K_USEPV="yes"
UNIPATCH_STRICTORDER="yes"
K_SECURITY_UNSUPPORTED="1"

RESTRICT="binchecks strip primaryuri mirror"

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
ZEN_DRM_FILE="${ZEN_KERNEL}-zen${ZEN_PATCHSET}-drmnext.patch"
ZEN_URI="http://downloads.zen-kernel.org/$(get_version_component_range 1-3)/${ZEN_FILE}"
ZEN_DRM_URI="http://downloads.zen-kernel.org/$(get_version_component_range 1-3)/custom/${ZEN_DRM_FILE}"
SRC_URI="${KERNEL_URI} ${ZEN_URI} drm-next? ( ${ZEN_DRM_URI} )"

KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"
IUSE="drm-next"

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

src_unpack(){
	kernel-2_src_unpack
	cd "${S}"
	epatch "${DISTDIR}"/"${ZEN_FILE}"
	use drm-next && epatch "${DISTDIR}"/"${ZEN_DRM_FILE}"
}

K_EXTRAEINFO="For more info on zen-sources and details on how to report problems, see: \
${HOMEPAGE}. You may also visit #zen-sources on irc.rizon.net"
