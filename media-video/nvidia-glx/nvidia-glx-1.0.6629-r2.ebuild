# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-glx/nvidia-glx-1.0.6629-r2.ebuild,v 1.1 2005/01/18 07:36:07 eradicator Exp $

inherit eutils multilib

X86_PKG_V="pkg1"
AMD64_PKG_V="pkg2"
NV_V="${PV/1.0./1.0-}"
X86_NV_PACKAGE="NVIDIA-Linux-x86-${NV_V}"
AMD64_NV_PACKAGE="NVIDIA-Linux-x86_64-${NV_V}"

DESCRIPTION="NVIDIA X11 driver and GLX libraries"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="x86? ( ftp://download.nvidia.com/XFree86/Linux-x86/${NV_V}/${X86_NV_PACKAGE}-${X86_PKG_V}.run )
	amd64? (http://download.nvidia.com/XFree86/Linux-x86_64/${NV_V}/${AMD64_NV_PACKAGE}-${AMD64_PKG_V}.run)"

LICENSE="NVIDIA"
SLOT="0"

# This revision just changes behavior on amd64 2005.0
KEYWORDS="-* ~amd64"

RESTRICT="nostrip multilib-pkg-force"
IUSE="multilib"

DEPEND="virtual/libc
	virtual/x11
	>=x11-base/opengl-update-1.8.1
	~media-video/nvidia-kernel-${PV}"

PDEPEND="amd64? ( multilib? ( >=app-emulation/emul-linux-x86-nvidia-${PV} ) )"

PROVIDE="virtual/opengl"
export _POSIX2_VERSION="199209"

if use x86; then
	PKG_V="${X86_PKG_V}"
	NV_PACKAGE="${X86_NV_PACKAGE}"
elif use amd64; then
	PKG_V="${AMD64_PKG_V}"
	NV_PACKAGE="${AMD64_NV_PACKAGE}"
fi

S="${WORKDIR}/${NV_PACKAGE}-${PKG_V}"

check_xfree() {
	# This isn't necessary, true. But its about time people got the idea.
	if has_version "x11-base/xfree"; then
		eerror "Support for x11-base/xfree is deprecated. Upgrade to x11-base/xorg-x11."
	fi
}

pkg_setup() {
	check_xfree

	# Provide some information to the users
	if use amd64 && ! has_multilib_profile && use !multilib; then
		einfo
		einfo "This release of nvidia-glx contains 32 bit compatibility"
		einfo "libraries. These can be installed by either"
		einfo "  1) emerge app-emulation/emul-linux-x86-nvidia"
		einfo "  2) USE=\"multilib\" emerge media-video/nvidia-glx"
		einfo "     (or /etc/portage/package.use, see portage manual)"
		einfo
	fi

	if use amd64 && has_multilib_profile && [ "${DEFAULT_ABI}" != "amd64" ]; then
		eerror "This ebuild doesn't currently support changing your defualt abi."
		die "Unexpected \${DEFAULT_ABI} = ${DEFAULT_ABI}"
	fi
}

src_unpack() {
	cd ${WORKDIR}
	bash ${DISTDIR}/${NV_PACKAGE}-${PKG_V}.run --extract-only

	# Patchs go below here, add breif description
	cd ${S}
	# nVidia wants us to use nvidia-installer, removing warning.
	epatch ${FILESDIR}/${PV}/NVIDIA_glx-${PV}-makefile.patch
	# Use the correct defines to make gtkglext build work
	epatch ${FILESDIR}/${PV}/NVIDIA_glx-${PV}-defines.patch
	# Use some more sensible gl headers and make way for new glext.h
	epatch ${FILESDIR}/${PV}/NVIDIA_glx-${PV}-glheader.patch

	# Closing bug #37517 by letting virtual/x11 provide system wide glext.h
	# 16 July 2004, opengl-update is now supplying glext.h for system wide
	# compatibility, so we still need to remove this.
	# 7 November 2004, Keeping this around for 6629 to see what happens.
	#rm -f usr/include/GL/glext.h
}

src_install() {
	if [ "${MLTEST/set_abi}" = "${MLTEST}" ]; then
		local OABI=${ABI}
		for ABI in $(get_abi_order); do
			src_install-libs
		done
		ABI=${OABI}
		unset OABI
	else
		src_install-libs
	fi

	is_final_abi || return 0

	# The X module
	# Since we moved away from libs in /usr/X11R6 need to check this
	if has_version ">=x11-base/xorg-x11-6.8.0-r4" ; then
		local X11_LIB_DIR="/usr/$(get_libdir)"
	else
		local X11_LIB_DIR="/usr/X11R6/$(get_libdir)"
	fi

	exeinto ${X11_LIB_DIR}/modules/drivers
	doexe usr/X11R6/lib/modules/drivers/nvidia_drv.o

	# Install tls_test
	dodir /usr/libexec/misc
	exeinto /usr/libexec/misc
	doexe usr/bin/tls_test
	doexe usr/bin/tls_test_dso.so

	insinto ${X11_LIB_DIR}
	doins usr/X11R6/lib/libXvMCNVIDIA.a
	exeinto ${X11_LIB_DIR}
	doexe usr/X11R6/lib/libXvMCNVIDIA.so.${PV}

	# Docs, remove nvidia-settings as provided by media-video/nvidia-settings
	rm -f usr/share/doc/nvidia-settings*
	dodoc usr/share/doc/*

	# nVidia want bug reports using this script
	exeinto /usr/bin
	doexe usr/bin/nvidia-bug-report.sh
}

src_install-libs() {
	local NV_ROOT="/usr/$(get_libdir)/opengl/nvidia"
	local pkglibdir=lib

	if has_multilib_profile && [ "${ABI}" == "x86" ]; then
		pkglibdir=lib32
	fi

	# The GLX libraries
	exeinto ${NV_ROOT}/lib
	doexe usr/${pkglibdir}/libGL.so.${PV} \
	      usr/${pkglibdir}/libGLcore.so.${PV} \
		  usr/${pkglibdir}/libnvidia-tls.so.${PV}
	dosym libGL.so.${PV} ${NV_ROOT}/lib/libGL.so
	dosym libGL.so.${PV} ${NV_ROOT}/lib/libGL.so.1
	dosym libGLcore.so.${PV} ${NV_ROOT}/lib/libGLcore.so
	dosym libGLcore.so.${PV} ${NV_ROOT}/lib/libGLcore.so.1
	dosym libnvidia-tls.so.${PV} ${NV_ROOT}/lib/libnvidia-tls.so
	dosym libnvidia-tls.so.${PV} ${NV_ROOT}/lib/libnvidia-tls.so.1

	local TLS_ROOT="/usr/$(get_libdir)/opengl/nvidia/tls"
	dodir ${TLS_ROOT}
	exeinto ${TLS_ROOT}
	doexe usr/${pkglibdir}/tls/libnvidia-tls.so.${PV}
	dosym libnvidia-tls.so.${PV} ${TLS_ROOT}/libnvidia-tls.so
	dosym libnvidia-tls.so.${PV} ${TLS_ROOT}/libnvidia-tls.so.1

	# Not sure whether installing the .la file is neccessary;
	# this is adopted from the `nvidia' ebuild
	#local ver1="`echo ${PV} |cut -d '.' -f 1`"
	#local ver2="`echo ${PV} |cut -d '.' -f 2`"
	#local ver3="`echo ${PV} |cut -d '.' -f 3`"
	#sed -e "s:\${PV}:${PV}:"     \
	#	-e "s:\${ver1}:${ver1}:" \
	#	-e "s:\${ver2}:${ver2}:" \
	#	-e "s:\${ver3}:${ver3}:" \
	#	${FILESDIR}/libGL.la > ${D}/${NV_ROOT}/lib/libGL.la

	# The GLX extension
	if is_final_abi; then
		exeinto ${NV_ROOT}/extensions
		newexe usr/X11R6/lib/modules/extensions/libglx.so.${PV} libglx.so

		# Includes
		insinto ${NV_ROOT}/include
		doins usr/include/GL/*.h
	fi
}

pkg_preinst() {
	# Clean the dinamic libGL stuff's home to ensure
	# we dont have stale libs floating around
	if [ -d ${ROOT}/usr/lib/opengl/nvidia ]
	then
		rm -rf ${ROOT}/usr/lib/opengl/nvidia/*
	fi
	# Make sure we nuke the old nvidia-glx's env.d file
	if [ -e ${ROOT}/etc/env.d/09nvidia ]
	then
		rm -f ${ROOT}/etc/env.d/09nvidia
	fi
}

pkg_postinst() {
	#switch to the nvidia implementation
	if [ "${ROOT}" = "/" ]
	then
		/usr/sbin/opengl-update nvidia
	fi

	echo
	einfo "To use the Nvidia GLX, run \"opengl-update nvidia\""
	echo
	einfo "You may also be interested in media-video/nvidia-settings"
	echo
	einfo "nVidia have requested that any bug reports submitted have the"
	einfo "output of /usr/bin/nvidia-bug-report.sh included."
}
