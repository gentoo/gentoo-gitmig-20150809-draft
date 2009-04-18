# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/x11-drm/x11-drm-20090320.ebuild,v 1.5 2009/04/18 22:47:33 battousai Exp $

inherit eutils x11 linux-mod autotools

IUSE_VIDEO_CARDS="
	video_cards_mach64
	video_cards_mga
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
			sys-freebsd/freebsd-mk-defs )
	>=x11-libs/libdrm-2.4.3"
RDEPEND=""

pkg_setup() {
	ewarn "The intel DRM module has been removed from x11-drm. Please use the in-kernel"
	ewarn "DRM module. This package is no longer useful for intel video cards."

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
		if kernel_is 2 4
		then
			eerror "Upstream support for 2.4 kernels has been removed, so this package will no"
			eerror "longer support them."
			die "Please use in-kernel DRM or switch to a 2.6 kernel."
		fi

		CONFIG_CHECK="!DRM"
		ERROR_DRM="Please disable DRM in the kernel config. (CONFIG_DRM = n)"

		linux-mod_pkg_setup
	fi
}

set_vidcards() {
	VIDCARDS=""

	if [[ -n "${VIDEO_CARDS}" ]]; then
		use video_cards_mach64 && \
			VIDCARDS="${VIDCARDS} mach64.${KV_OBJ}"
		use video_cards_mga && \
			VIDCARDS="${VIDCARDS} mga.${KV_OBJ}"
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
