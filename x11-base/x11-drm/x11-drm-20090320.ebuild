# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/x11-drm/x11-drm-20090320.ebuild,v 1.1 2009/03/21 00:23:02 battousai Exp $

inherit eutils x11 linux-mod autotools

IUSE_VIDEO_CARDS="
	video_cards_mach64
	video_cards_mga
	video_cards_nv
	video_cards_r128
	video_cards_radeon
	video_cards_radeonhd
	video_cards_savage
	video_cards_sis
	video_cards_sunffb
	video_cards_tdfx
	video_cards_via
	video_cards_xgi"
IUSE="${IUSE_VIDEO_CARDS} kernel_FreeBSD kernel_linux"

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
# Tests require user intervention (see bug #236845)
RESTRICT="strip test"

S="${WORKDIR}/drm"
PATCHVER="0.1"
PATCHDIR="${WORKDIR}/patch"
EXCLUDED="${WORKDIR}/excluded"

DESCRIPTION="DRM Kernel Modules for X11"
HOMEPAGE="http://dri.sf.net"
SRC_URI="mirror://gentoo/linux-drm-${PV}-kernelsource.tar.bz2"
if [ -n "${PATCHVER}" ] ; then
	SRC_URI="${SRC_URI} mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2"
fi

SLOT="0"
LICENSE="X11"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86 ~x86-fbsd"

DEPEND="kernel_linux? ( virtual/linux-sources )
	kernel_FreeBSD? ( sys-freebsd/freebsd-sources
			sys-freebsd/freebsd-mk-defs )"
RDEPEND=""

pkg_setup() {
	# Setup the kernel's stuff.
	kernel_setup

	# Set video cards to build for.
	set_vidcards

	# Determine which -core dir we build in.
	get_drm_build_dir

	return 0
}

src_unpack() {
	unpack linux-drm-${PV}-kernelsource.tar.bz2
	cd "${WORKDIR}"

	# Apply patches if there's a patchball version number provided.
	if [ -n "${PATCHVER}"  ]
	then
		unpack ${P}-gentoo-${PATCHVER}.tar.bz2
		cd "${S}"

		patch_prepare

		# Apply patches
		EPATCH_SUFFIX="patch" epatch ${PATCHDIR}
	fi
	eautoreconf -v --install

	src_unpack_os
}

src_compile() {
	einfo "Building DRM in ${SRC_BUILD}..."
	src_compile_os
	einfo "DRM build finished".

	cd "${S}"

	# I need to work on my autoconf skills to make reliable user-selection
	# of cairo support here.
	econf --without-cairo || die "econf failed"

	cd "${S}"/tests
	emake || die "Failed to build programs."
}

src_install() {
	einfo "Installing DRM..."
	cd "${SRC_BUILD}"

	src_install_os

	cd "${S}"/tests
	dobin dristat drmstat modeprint/modeprint modetest/modetest || die

	dodoc "${S}/linux-core/README.drm"
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
		einfo "http://dri.freedesktop.org/wiki/ATIMach64."
	fi

	pkg_postinst_os
}

# Functions used above are defined below:

kernel_setup() {
	if use kernel_FreeBSD
	then
		K_RV=${CHOST/*-freebsd/}
	elif use kernel_linux
	then
		linux-mod_pkg_setup

		if kernel_is 2 4
		then
			eerror "Upstream support for 2.4 kernels has been removed, so this package will no"
			eerror "longer support them."
			die "Please use in-kernel DRM or switch to a 2.6 kernel."
		fi

		linux_chkconfig_builtin "DRM" && \
			die "Please disable or modularize DRM in the kernel config. (CONFIG_DRM = n or m)"

		CONFIG_CHECK="AGP"
		ERROR_AGP="AGP support is not enabled in your kernel config (CONFIG_AGP)"
	fi
}

set_vidcards() {
	VIDCARDS=""

	if [[ -n "${VIDEO_CARDS}" ]]; then
		use video_cards_mach64 && \
			VIDCARDS="${VIDCARDS} mach64.${KV_OBJ}"
		use video_cards_mga && \
			VIDCARDS="${VIDCARDS} mga.${KV_OBJ}"
		use video_cards_nv && \
			VIDCARDS="${VIDCARDS} nouveau.${KV_OBJ}"
		use video_cards_r128 && \
			VIDCARDS="${VIDCARDS} r128.${KV_OBJ}"
		use video_cards_radeon || use video_cards_radeonhd && \
			VIDCARDS="${VIDCARDS} radeon.${KV_OBJ}"
		use video_cards_savage && \
			VIDCARDS="${VIDCARDS} savage.${KV_OBJ}"
		use video_cards_sis && \
			VIDCARDS="${VIDCARDS} sis.${KV_OBJ}"
		use video_cards_via && \
			VIDCARDS="${VIDCARDS} via.${KV_OBJ}"
		use video_cards_sunffb && \
			VIDCARDS="${VIDCARDS} ffb.${KV_OBJ}"
		use video_cards_tdfx && \
			VIDCARDS="${VIDCARDS} tdfx.${KV_OBJ}"
		use video_cards_xgi && \
			VIDCARDS="${VIDCARDS} xgi.${KV_OBJ}"
	fi
}

get_drm_build_dir() {
	if use kernel_FreeBSD
	then
		SRC_BUILD="${S}/bsd-core"
	elif kernel_is 2 6
	then
		SRC_BUILD="${S}/linux-core"
	fi
}

patch_prepare() {
	# Handle exclusions based on the following...
	#     All trees (0**), Standard only (1**), Others (none right now)
	#     2.4 vs. 2.6 kernels
	if use kernel_linux
	then
	    kernel_is 2 6 && mv -f "${PATCHDIR}"/*kernel-2.4* "${EXCLUDED}"
	fi

	# There is only one tree being maintained now. No numeric exclusions need
	# to be done based on DRM tree.
}

src_unpack_linux() {
	convert_to_m "${SRC_BUILD}"/Makefile
}

src_unpack_freebsd() {
	# Link in freebsd kernel.
	ln -s "/usr/src/sys-${K_RV}" "${WORKDIR}/sys"
	# SUBDIR variable gets to all Makefiles, we need it only in the main one.
	SUBDIRS=${VIDCARDS//.ko}
	sed -i -e "s:SUBDIR\ =.*:SUBDIR\ =\ drm ${SUBDIRS}:" "${SRC_BUILD}"/Makefile
}

src_unpack_os() {
	if use kernel_linux; then
		src_unpack_linux
	elif use kernel_FreeBSD
	then
		src_unpack_freebsd
	fi
}

src_compile_os() {
	if use kernel_linux
	then
		src_compile_linux
	elif use kernel_FreeBSD
	then
		src_compile_freebsd
	fi
}

src_install_os() {
	if use kernel_linux
	then
		src_install_linux
	elif use kernel_FreeBSD
	then
		src_install_freebsd
	fi
}

src_compile_linux() {
	# remove leading and trailing space
	VIDCARDS="${VIDCARDS% }"
	VIDCARDS="${VIDCARDS# }"

	check_modules_supported
	MODULE_NAMES=""
	for i in drm.${KV_OBJ} ${VIDCARDS}; do
		MODULE_NAMES="${MODULE_NAMES} ${i/.${KV_OBJ}}(${PN}:${SRC_BUILD})"
		i=$(echo ${i/.${KV_OBJ}} | tr '[:lower:]' '[:upper:]')
		eval MODULESD_${i}_ENABLED="yes"
	done

	# This now uses an M= build system. Makefile does most of the work.
	cd "${SRC_BUILD}"
	unset ARCH
	BUILD_TARGETS="modules"
	BUILD_PARAMS="DRM_MODULES='${VIDCARDS}' LINUXDIR='${KERNEL_DIR}' M='${SRC_BUILD}'"
	ECONF_PARAMS='' S="${SRC_BUILD}" linux-mod_src_compile

	if linux_chkconfig_present DRM
	then
		ewarn "Please disable in-kernel DRM support to use this package."
	fi
}

src_compile_freebsd() {
	cd "${SRC_BUILD}"
	# Environment CFLAGS overwrite kernel CFLAGS which is bad.
	local svcflags=${CFLAGS}; local svldflags=${LDFLAGS}
	unset CFLAGS; unset LDFLAGS
	MAKE=make \
		emake \
		NO_WERROR= \
		SYSDIR="${WORKDIR}/sys" \
		KMODDIR="/boot/modules" \
		|| die "pmake failed."
	export CFLAGS=${svcflags}; export LDFLAGS=${svldflags}
}

die_error() {
	eerror "Portage could not build the DRM modules. If you see an ACCESS DENIED error,"
	eerror "this could mean that you were using an unsupported kernel build system."
	eerror "Only 2.6 kernels at least as new as 2.6.6 are supported."
	die "Unable to build DRM modules."
}

src_install_linux() {
	linux-mod_src_install

	# Strip binaries, leaving /lib/modules untouched (bug #24415)
	strip_bins \/lib\/modules
}

src_install_freebsd() {
	cd "${SRC_BUILD}"
	dodir "/boot/modules"
	MAKE=make \
		emake \
		install \
		NO_WERROR= \
		DESTDIR="${D}" \
		KMODDIR="/boot/modules" \
		|| die "Install failed."
}

pkg_postinst_os() {
	if use kernel_linux
	then
		linux-mod_pkg_postinst
	fi
}
