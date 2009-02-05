# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/x11-drm/x11-drm-20080710.ebuild,v 1.8 2009/02/05 13:36:41 remi Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="1.7"

inherit eutils x11 linux-mod autotools

IUSE_VIDEO_CARDS="
	video_cards_intel
	video_cards_mach64
	video_cards_mga
	video_cards_nv
	video_cards_r128
	video_cards_radeon
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
PATCHVER="0.5"
PATCHDIR="${WORKDIR}/patch"
EXCLUDED="${WORKDIR}/excluded"

DESCRIPTION="DRM Kernel Modules for X11"
HOMEPAGE="http://dri.sf.net"
SRC_URI="mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2
	 mirror://gentoo/linux-drm-${PV}-kernelsource.tar.bz2"

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

	# Determine which -core dir we build in.
	get_drm_build_dir

	# Set video cards to build for.
	set_vidcards

	return 0
}

src_unpack() {
	unpack linux-drm-${PV}-kernelsource.tar.bz2
	unpack ${P}-gentoo-${PATCHVER}.tar.bz2

	patch_prepare

	# Apply patches
	EPATCH_SUFFIX="patch" epatch "${PATCHDIR}"

	# Substitute new directory under /lib/modules/${KV_FULL}
	cd "${SRC_BUILD}"
	sed -ie "s:/kernel/drivers/char/drm:/${PN}:g" Makefile

	cp "${S}"/tests/*.c "${SRC_BUILD}"

	src_unpack_os

	cd "${S}"
	eautoreconf -v --install
}

src_compile() {
	# Building the programs. These are useful for developers and getting info from DRI and DRM.
	#
	# libdrm objects are needed for drmstat.
	econf || die "libdrm configure failed."
	emake || die "libdrm build failed."

	einfo "Building DRM in ${SRC_BUILD}..."
	src_compile_os
	einfo "DRM build finished".
}

src_install() {
	einfo "Installing DRM..."
	cd "${SRC_BUILD}"

	src_install_os

	dodoc "${S}/linux-core/README.drm"

	dobin dristat
	dobin drmstat
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
		if kernel_is 2 4
		then
			eerror "Upstream support for 2.4 kernels has been removed, so this package will no"
			eerror "longer support them."
			die "Please use in-kernel DRM or switch to a 2.6 kernel."
		fi

		CONFIG_CHECK="!DRM AGP"
		ERROR_DRM="Please disable DRM in the kernel config. (CONFIG_DRM = n)"
		ERROR_AGP="AGPGART support is not enabled in your kernel config (CONFIG_AGP)."

		linux-mod_pkg_setup
	fi
}

set_vidcards() {
	if use kernel_linux; then
		set_kvobj
		INTEL_VIDCARDS="i810.${KV_OBJ} i915.${KV_OBJ}"
	elif use kernel_FreeBSD; then
		KV_OBJ="ko"
		# bsd does not have i810, only i915:
		INTEL_VIDCARDS="i915.${KV_OBJ}"
	fi

	VIDCARDS=""

	if [[ -n "${VIDEO_CARDS}" ]]; then
		use video_cards_intel && \
			VIDCARDS="${VIDCARDS} ${INTEL_VIDCARDS}"
		use video_cards_mach64 && \
			VIDCARDS="${VIDCARDS} mach64.${KV_OBJ}"
		use video_cards_mga && \
			VIDCARDS="${VIDCARDS} mga.${KV_OBJ}"
		use video_cards_nv && \
			VIDCARDS="${VIDCARDS} nv.${KV_OBJ} nouveau.${KV_OBJ}"
		use video_cards_r128 && \
			VIDCARDS="${VIDCARDS} r128.${KV_OBJ}"
		use video_cards_radeon && \
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

	MODULE_NAMES=""
	if use kernel_linux
	then
		LIBDIR="x11-drm"
		for VIDCARD in ${VIDCARDS}
		do
			MODULE_NAMES="${MODULE_NAMES} ${VIDCARD/\.${KV_OBJ}/(${LIBDIR}:${SRC_BUILD})}"
		done
		MODULE_NAMES="${MODULE_NAMES} drm(${LIBDIR}:${SRC_BUILD})"
		BUILD_PARAMS="LINUXDIR=\"${KERNEL_DIR}\" DRM_MODULES=\"${VIDCARDS}\""
		BUILD_TARGETS="modules"
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

src_unpack_freebsd() {
	# Do FreeBSD stuff.
	if use kernel_FreeBSD
	then
		# Link in freebsd kernel.
		ln -s "/usr/src/sys-${K_RV}" "${WORKDIR}/sys"
		# SUBDIR variable gets to all Makefiles, we need it only in the main one.
		SUBDIRS=${VIDCARDS//.ko}
		sed -ie "s:SUBDIR\ =.*:SUBDIR\ =\ drm ${SUBDIRS}:" "${SRC_BUILD}"/Makefile
	fi
}

src_unpack_os() {
	if use kernel_FreeBSD
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
	# This now uses an M= build system. Makefile does most of the work.
	linux-mod_src_compile

	# LINUXDIR is needed to allow Makefiles to find kernel release.
	cd "${SRC_BUILD}"
	emake LINUXDIR="${KERNEL_DIR}" dristat || die "Building dristat failed."
	emake LINUXDIR="${KERNEL_DIR}" drmstat || die "Building drmstat failed."
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

	cd "${S}/tests"
	# -D_POSIX_SOURCE skips the definition of several stuff we need
	# for these two to compile
	sed -i -e "s/-D_POSIX_SOURCE//" Makefile
	emake dristat || die "Building dristat failed."
	emake drmstat || die "Building drmstat failed."
	# Move these where the linux stuff expects them
	mv dristat drmstat "${SRC_BUILD}"
}

die_error() {
	eerror "Portage could not build the DRM modules. If you see an ACCESS DENIED error,"
	eerror "this could mean that you were using an unsupported kernel build system."
	eerror "Only 2.6 kernels at least as new as 2.6.6 are supported."
	die "Unable to build DRM modules."
}

src_install_linux() {
	cd "${SRC_BUILD}"
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

		elog "Having in-kernel DRM modules installed can prevent x11-drm modules from being"
		elog "loaded. It can also lead to unknown symbols in x11-drm modules, which would"
		elog "be seen during the installation. If you experience any of those problems,"
		elog "please ensure that the in-kernel DRM modules are not installed."
		elog "This can be done with the following:"
		elog "    cd ${KERNEL_DIR}"
		elog "    make modules modules_install"
		elog "This should allow the x11-drm modules to load and function normally."
	fi
}
