# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/x11-drm/x11-drm-20040827.ebuild,v 1.5 2004/11/04 21:29:43 battousai Exp $

inherit eutils x11 kernel-mod

IUSE="gatos"
IUSE_VIDEO_CARDS="3dfx ffb i810 i830 i915 mach64 matrox rage128 radeon savage sis via"

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

GATOSSNAP="20031202"
PATCHVER="0.1"
PATCHDIR="${WORKDIR}/patch"
EXCLUDED="${WORKDIR}/excluded"
S="${WORKDIR}/drm"
DESCRIPTION="DRM Kernel Modules for X11"
HOMEPAGE="http://dri.sf.net"
SRC_URI="mirror://gentoo/${PF}-gentoo-${PATCHVER}.tar.bz2
	 mirror://gentoo/linux-drm-${PV}-kernelsource.tar.bz2
	 gatos? ( mirror://gentoo/linux-drm-gatos-${GATOSSNAP}-kernelsource.tar.bz2 )"

SLOT="${KV}"
LICENSE="X11"
KEYWORDS="~x86 ~alpha ~ia64 ~ppc"

DEPEND="virtual/x11
	virtual/linux-sources
	>=sys-apps/portage-2.0.49-r13"

PROVIDE="virtual/drm"

pkg_setup() {
	get_kernel_info

	# Require at least one video card
	if [ -z "${VIDEO_CARDS}" ]
	then
		die "Please set at least one video card in VIDEO_CARDS in make.conf or the environment. Possible VIDEO_CARDS values are: ${IUSE_VIDEO_CARDS}."
	fi

	if [ "${ARCH}" != "sparc" ] && use video_cards_ffb
	then
		die "The ffb driver is for sparc-specific hardware. Please remove it from your VIDEO_CARDS."
	fi

	# GATOS only works with radeon, rage128. mach64 is provided by drm trunk.
	if use gatos
	then
		if ! use video_cards_radeon && ! use video_cards_rage128
		then
			die "Remove gatos from your USE flags. It does not work with cards other than radeon and rage128."
		fi
		kernel-mod_is_2_6_kernel && die "GATOS does not work with 2.6 kernels. Only 2.4 is supported at this time."
	fi

	ewarn "Using koutput kernels is now deprecated. If you use a koutput kernel, please"
	ewarn "switch to kernel >=2.6.6 with a normal build system."

	# Set video cards to build for.
	set_vidcards

	return 0
}

src_unpack() {
	if use gatos
	then
		unpack linux-drm-gatos-${GATOSSNAP}-kernelsource.tar.bz2
	else
		unpack linux-drm-${PV}-kernelsource.tar.bz2
	fi
	unpack ${PF}-gentoo-${PATCHVER}.tar.bz2

	cd ${S}
	cp ${PATCHDIR}/Makefile ${S}

	patch_prepare

	# Apply patches
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}

	# Substitute new directory under /lib/modules/${KV}
	sed -ie "s:/kernel/drivers/char/drm:/${PN}:g" Makefile
	sed -ie "s:xfree-drm:${PN}:g" Makefile
}

src_compile() {
	einfo "Building DRM..."

	# This now uses an M= build system. Makefile does most of the work.
	unset ARCH
	make M="${S}" \
		LINUXDIR="${ROOT}/usr/src/linux" \
		DRM_MODULES="${VIDCARDS}" \
		DRMSRCDIR="${S}" \
		modules || die_error

	# dristat in GATOS seems busted.
	if ! use gatos
	then
		make dristat || die "Building dristat failed."
	fi
}

src_install() {
	einfo "Installing DRM..."

	unset ARCH
	make KV="${KV}" \
		LINUXDIR="${ROOT}/usr/src/linux" \
		DRM_MODULES="${VIDCARDS}" \
		DESTDIR="${D}" \
		install || die "Install failed."

	dodoc README*

	if ! use gatos
	then
		exeinto /usr/X11R6/bin
		doexe dristat

		# Strip binaries, leaving /lib/modules untouched (bug #24415)
		strip_bins \/lib\/modules
	fi

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
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}

# Functions used above are defined below:

set_vidcards() {
	if kernel-mod_is_2_6_kernel
	then
		KV_OBJ="ko"
	else
		KV_OBJ="o"
	fi

	# To get the kernel module extension
#	get_kernel_info

	VIDCARDS=""

	use video_cards_matrox && \
		VIDCARDS="${VIDCARDS} mga.${KV_OBJ}"
	use video_cards_3dfx && \
		VIDCARDS="${VIDCARDS} tdfx.${KV_OBJ}"
	use video_cards_rage128 && \
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
	#     GATOS (2xx*) vs. Standard trees (1xx*)
	#     2.4 vs. 2.6 kernels

	kernel-mod_is_2_4_kernel && mv -f ${PATCHDIR}/*kernel-2.6* ${EXCLUDED}
	kernel-mod_is_2_6_kernel && mv -f ${PATCHDIR}/*kernel-2.4* ${EXCLUDED}

	if use gatos
	then
		einfo "Updating for GATOS build..."
		mv -f ${PATCHDIR}/1* ${EXCLUDED}
		# Don't bother with dristat, it's broken
		mv -f ${PATCHDIR}/*dristat* ${EXCLUDED}
	else
		einfo "Updating for standard build..."
		mv -f ${PATCHDIR}/2* ${EXCLUDED}
	fi
}

die_error() {
	eerror "Portage could not build the DRM modules. If you see an ACCESS DENIED error,"
	eerror "this could mean that you were using an unsupported kernel build system. All"
	eerror "2.4 kernels are supported, but only 2.6 kernels at least as new as 2.6.6"
	eerror "are supported."
	die "Unable to build DRM modules."
}
