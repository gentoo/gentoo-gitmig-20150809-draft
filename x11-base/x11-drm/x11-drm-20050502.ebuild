# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/x11-drm/x11-drm-20050502.ebuild,v 1.5 2006/04/16 20:16:03 spyderous Exp $

inherit eutils x11 linux-mod

IUSE=""
IUSE_VIDEO_CARDS="3dfx ffb i810 i830 i915 mach64 mga r128 radeon savage sis via"

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

S="${WORKDIR}/drm"
PATCHVER="0.2"
PATCHDIR="${WORKDIR}/patch"
EXCLUDED="${WORKDIR}/excluded"

DESCRIPTION="DRM Kernel Modules for X11"
HOMEPAGE="http://dri.sf.net"
SRC_URI="mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2
	 mirror://gentoo/linux-drm-${PV}-kernelsource.tar.bz2"

SLOT="${KV}"
LICENSE="X11"
KEYWORDS="x86 ~alpha ~ia64 ~ppc ~amd64"

DEPEND="virtual/linux-sources
	>=sys-apps/portage-2.0.49-r13"

pkg_setup() {
	get_version

	# Require at least one video card
	if [ -z "${VIDEO_CARDS}" ]
	then
		die "Please set at least one video card in VIDEO_CARDS in make.conf or the environment. Possible VIDEO_CARDS values are: ${IUSE_VIDEO_CARDS}."
	fi

	if [ "${ARCH}" != "sparc" ] && use video_cards_ffb
	then
		die "The ffb driver is for sparc-specific hardware. Please remove it from your VIDEO_CARDS."
	fi

	if linux_chkconfig_builtin "DRM"
	then
		die "Please disable or modularize DRM in the kernel config. (CONFIG_DRM = n or m)"
	fi

	if ! linux_chkconfig_present "AGP"
	then
		einfo "AGP support is not enabled in your kernel config. This may be needed for DRM to"
		einfo "work, so you might want to double-check that setting. (CONFIG_AGP)"
		echo
	fi

	# Set video cards to build for.
	set_vidcards

	# DRM CVS is undergoing changes which require splitting source to support both 2.4
	# and 2.6 kernels. This determines which to use.
	get_drm_build_dir

	return 0
}

src_unpack() {
	unpack linux-drm-${PV}-kernelsource.tar.bz2
	unpack ${P}-gentoo-${PATCHVER}.tar.bz2

	cd ${S}

	patch_prepare

	# Apply patches
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}

	# Substitute new directory under /lib/modules/${KV}
	cd ${SRC_BUILD}
	sed -ie "s:/kernel/drivers/char/drm:/${PN}:g" Makefile

	cp ${S}/tests/*.c ${SRC_BUILD}
}

src_compile() {
	einfo "Building DRM in ${SRC_BUILD}..."
	cd ${SRC_BUILD}

	# This now uses an M= build system. Makefile does most of the work.
	unset ARCH
	make M="${SRC_BUILD}" \
		LINUXDIR="${ROOT}/usr/src/linux" \
		DRM_MODULES="${VIDCARDS}" \
		modules || die_error

	# Building the programs. These are useful for developers and getting info from DRI and DRM.
	#
	# libdrm objects are needed for drmstat.
	cd ${S}/libdrm
	make || die "Could not build libdrm"

	if linux_chkconfig_present DRM
	then
		echo "Please disable in-kernel DRM support to use this package."
	fi

	cd ${SRC_BUILD}
	# LINUXDIR is needed to allow Makefiles to find kernel release.
	make LINUXDIR="${ROOT}/usr/src/linux" dristat || die "Building dristat failed."
	make LINUXDIR="${ROOT}/usr/src/linux" drmstat || die "Building drmstat failed."
}

src_install() {
	einfo "Installing DRM..."
	cd ${SRC_BUILD}

	unset ARCH
	make KV="${KV}" \
		LINUXDIR="${ROOT}/usr/src/linux" \
		DESTDIR="${D}" \
		RUNNING_REL="${KV}" \
		MODULE_LIST="${VIDCARDS} drm.${KV_OBJ}" \
		install || die "Install failed."

	dodoc README.drm

	dobin dristat
	dobin drmstat

	# Strip binaries, leaving /lib/modules untouched (bug #24415)
	strip_bins \/lib\/modules

	# Yoinked from the sys-apps/touchpad ebuild. Thanks to whoever made this.
	keepdir /etc/modules.d
	sed 's:%PN%:'${PN}':g' ${FILESDIR}/modules.d-${PN} > ${D}/etc/modules.d/${PN}
	sed -i 's:%KV%:'${KV}':g' ${D}/etc/modules.d/${PN}
}

pkg_postinst() {
	if use video_cards_sis
	then
		einfo "SiS direct rendering only works on 300 series chipsets."
		einfo "SiS framebuffer also needs to be enabled in the kernel."
	fi

	if use video_cards_mach64
	then
		einfo "The Mach64 DRI driver is insecure."
		einfo "Malicious clients can write to system memory."
		einfo "For more information, see:"
		einfo "http://dri.sourceforge.net/cgi-bin/moin.cgi/ATIMach64?value=CategoryHardwareChipset."
	fi

	einfo "Checking kernel module dependencies"
	update_modules
	update_depmod
}

# Functions used above are defined below:

set_vidcards() {
	set_kvobj

	VIDCARDS=""

	use video_cards_mga && \
		VIDCARDS="${VIDCARDS} mga.${KV_OBJ}"
	use video_cards_3dfx && \
		VIDCARDS="${VIDCARDS} tdfx.${KV_OBJ}"
	use video_cards_r128 && \
		VIDCARDS="${VIDCARDS} r128.${KV_OBJ}"
	use video_cards_radeon && \
		VIDCARDS="${VIDCARDS} radeon.${KV_OBJ}"
	use video_cards_i810 && \
		VIDCARDS="${VIDCARDS} i810.${KV_OBJ}"
	use video_cards_i830 && \
		VIDCARDS="${VIDCARDS} i830.${KV_OBJ}"
	use video_cards_i915 && \
		VIDCARDS="${VIDCARDS} i915.${KV_OBJ}"
#	use video_cards_gamma && \
#		VIDCARDS="${VIDCARDS} gamma.${KV_OBJ}"
	use video_cards_mach64 && \
		VIDCARDS="${VIDCARDS} mach64.${KV_OBJ}"
	use video_cards_savage && \
		VIDCARDS="${VIDCARDS} savage.${KV_OBJ}"
	use video_cards_sis && \
		VIDCARDS="${VIDCARDS} sis.${KV_OBJ}"
	use video_cards_via && \
		VIDCARDS="${VIDCARDS} via.${KV_OBJ}"
	use video_cards_ffb && \
		VIDCARDS="${VIDCARDS} ffb.${KV_OBJ}"
}

patch_prepare() {
	# Handle exclusions based on the following...
	#     All trees (0**), Standard only (1**), Others (none right now)
	#     2.4 vs. 2.6 kernels

	kernel_is 2 4 && mv -f ${PATCHDIR}/*kernel-2.6* ${EXCLUDED}
	kernel_is 2 6 && mv -f ${PATCHDIR}/*kernel-2.4* ${EXCLUDED}

	# There is only one tree being maintained now. No numeric exclusions need
	# to be done based on DRM tree.
}

die_error() {
	eerror "Portage could not build the DRM modules. If you see an ACCESS DENIED error,"
	eerror "this could mean that you were using an unsupported kernel build system. All"
	eerror "2.4 kernels are supported, but only 2.6 kernels at least as new as 2.6.6"
	eerror "are supported."
	die "Unable to build DRM modules."
}

get_drm_build_dir() {
	if kernel_is 2 4
	then
		SRC_BUILD="${S}/linux"
	elif kernel_is 2 6
	then
		SRC_BUILD="${S}/linux-core"
	fi
}
