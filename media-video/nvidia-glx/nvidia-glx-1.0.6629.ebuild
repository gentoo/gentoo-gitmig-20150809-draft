# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-glx/nvidia-glx-1.0.6629.ebuild,v 1.4 2004/11/30 01:33:12 cyfred Exp $

inherit eutils

X86_PKG_V="pkg1"
AMD64_PKG_V="pkg2"
NV_V="${PV/1.0./1.0-}"
X86_NV_PACKAGE="NVIDIA-Linux-x86-${NV_V}"
AMD64_NV_PACKAGE="NVIDIA-Linux-x86_64-${NV_V}"

DESCRIPTION="NVIDIA X11 driver and GLX libraries"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="x86? (ftp://download.nvidia.com/XFree86/Linux-x86/${NV_V}/${X86_NV_PACKAGE}-${X86_PKG_V}.run)
	amd64? (http://download.nvidia.com/XFree86/Linux-x86_64/${NV_V}/${AMD64_NV_PACKAGE}-${AMD64_PKG_V}.run)"

if use x86; then
	PKG_V="${X86_PKG_V}"
	NV_PACKAGE="${X86_NV_PACKAGE}"
elif use amd64; then
	PKG_V="${AMD64_PKG_V}"
	NV_PACKAGE="${AMD64_NV_PACKAGE}"
fi

S="${WORKDIR}/${NV_PACKAGE}-${PKG_V}"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
RESTRICT="nostrip"
IUSE="multilib"

DEPEND="virtual/libc
	virtual/x11
	>=x11-base/opengl-update-1.8.1
	~media-video/nvidia-kernel-${PV}"

PDEPEND="amd64? ( multilib? ( >=app-emulation/emul-linux-x86-nvidia-${PV} ) )"

PROVIDE="virtual/opengl"
export _POSIX2_VERSION="199209"

check_xfree() {
	# This isn't necessary, true. But its about time people got the idea.
	if has_version "x11-base/xfree"
	then
		eerror "Support for x11-base/xfree is deprecated. Upgrade to x11-base/xorg-x11."
	fi
}

pkg_setup() {
	check_xfree

	# Provide some information to the users
	if use amd64 ; then
		einfo
		einfo "This release of nvidia-glx contains 32 bit compatibility"
		einfo "libraries. These can be installed by either"
		einfo "  1) emerge app-emulation/emul-linux-x86-nvidia"
		einfo "  2) USE=\"multilib\" emerge media-video/nvidia-glx"
		einfo "     (or /etc/portage/package.use, see portage manual)"
		einfo
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

}

src_install() {
	local NV_ROOT="/usr/lib/opengl/nvidia"

	# The X module
	exeinto /usr/X11R6/lib/modules/drivers
	doexe usr/X11R6/lib/modules/drivers/nvidia_drv.o

	# The GLX extension
	exeinto ${NV_ROOT}/extensions
	newexe usr/X11R6/lib/modules/extensions/libglx.so.${PV} libglx.so

	# The GLX libraries
	exeinto ${NV_ROOT}/lib
	doexe usr/lib/libGL.so.${PV} \
	      usr/lib/libGLcore.so.${PV} \
		  usr/lib/libnvidia-tls.so.${PV}
	dosym libGL.so.${PV} ${NV_ROOT}/lib/libGL.so
	dosym libGL.so.${PV} ${NV_ROOT}/lib/libGL.so.1
	dosym libGLcore.so.${PV} ${NV_ROOT}/lib/libGLcore.so
	dosym libGLcore.so.${PV} ${NV_ROOT}/lib/libGLcore.so.1
	dosym libnvidia-tls.so.${PV} ${NV_ROOT}/lib/libnvidia-tls.so
	dosym libnvidia-tls.so.${PV} ${NV_ROOT}/lib/libnvidia-tls.so.1

	local TLS_ROOT="/usr/lib/opengl/nvidia/tls"
	dodir ${TLS_ROOT}
	exeinto ${TLS_ROOT}
	doexe usr/lib/tls/libnvidia-tls.so.${PV}
	dosym libnvidia-tls.so.${PV} ${TLS_ROOT}/libnvidia-tls.so
	dosym libnvidia-tls.so.${PV} ${TLS_ROOT}/libnvidia-tls.so.1

	# Install tls_test
	dodir /usr/lib/misc
	exeinto /usr/lib/misc
	doexe usr/bin/tls_test
	doexe usr/bin/tls_test_dso.so

	insinto /usr/X11R6/lib
	doins usr/X11R6/lib/libXvMCNVIDIA.a
	exeinto /usr/X11R6/lib
	doexe usr/X11R6/lib/libXvMCNVIDIA.so.${PV}

	# Closing bug #37517 by letting virtual/x11 provide system wide glext.h
	# 16 July 2004, opengl-update is now supplying glext.h for system wide
	# compatibility, so we still need to remove this.
	# 7 November 2004, Keeping this around for 6629 to see what happens.
	#rm -f usr/include/GL/glext.h

	# Includes
	insinto ${NV_ROOT}/include
	doins usr/include/GL/*.h

	# Docs, remove nvidia-settings as provided by media-video/nvidia-settings
	rm -f usr/share/doc/nvidia-settings*
	dodoc usr/share/doc/*

	# nVidia want bug reports using this script
	exeinto /usr/bin
	doexe usr/bin/nvidia-bug-report.sh

	# Not sure whether installing the .la file is neccessary;
	# this is adopted from the `nvidia' ebuild
	local ver1="`echo ${PV} |cut -d '.' -f 1`"
	local ver2="`echo ${PV} |cut -d '.' -f 2`"
	local ver3="`echo ${PV} |cut -d '.' -f 3`"
	sed -e "s:\${PV}:${PV}:"     \
		-e "s:\${ver1}:${ver1}:" \
		-e "s:\${ver2}:${ver2}:" \
		-e "s:\${ver3}:${ver3}:" \
		${FILESDIR}/libGL.la > ${D}/${NV_ROOT}/lib/libGL.la

	# Should we install the .la for the 32bit libs on amd64? I think not.
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
