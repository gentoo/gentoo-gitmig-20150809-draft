# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-glx/nvidia-glx-1.0.5336-r2.ebuild,v 1.10 2004/11/07 02:00:47 cyfred Exp $

inherit eutils

PKG_V="pkg1"
NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA-Linux-x86-${NV_V}"
S="${WORKDIR}/${NV_PACKAGE}-${PKG_V}"
DESCRIPTION="XFree86 GLX libraries for the NVIDIA's X driver"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="http://download.nvidia.com/XFree86/Linux-x86/${NV_V}/${NV_PACKAGE}-${PKG_V}.run"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="-* -x86"
IUSE=""
RESTRICT="nostrip"

DEPEND="virtual/libc
	virtual/x11
	>=x11-base/opengl-update-1.3
	~media-video/nvidia-kernel-${PV}"
PROVIDE="virtual/opengl"
export _POSIX2_VERSION="199209"

pkg_setup() {
	# We need xfree-4.2.0-r9 to support the dynamic libGL* stuff
	if has_version "x11-base/xfree"
	then
		if has_version "<x11-base/xfree-4.2.0-r9"
		then
			die "Upgrade to xfree 4.2.0-r9 or greater."
		fi
	fi
}

src_unpack() {
	cd ${WORKDIR}
	bash ${DISTDIR}/${NV_PACKAGE}-${PKG_V}.run --extract-only

	# Use the correct defines to make gtkglext build work
	cd ${S}; epatch ${FILESDIR}/${PN}-1.0.5328-defines.patch
	# Use correct glext API
	epatch ${FILESDIR}/${P}-glheader.patch
}

src_install() {
	local NV_ROOT="/usr/lib/opengl/nvidia"
	local TLS=

	# Check if we should install TLS versions of the libraries
	${S}/usr/bin/tls_test ${S}/usr/bin/tls_test_dso.so 2> /dev/null
	# Only trust this if we are merging to /
	if [ "$?" = "0" -a "${ROOT}" = "/" ]
	then
		einfo "Using TLS..."
		TLS="tls/"
	fi

	# The X module
	exeinto /usr/X11R6/lib/modules/drivers
	doexe usr/X11R6/lib/modules/drivers/nvidia_drv.o

	# The GLX extension
	exeinto ${NV_ROOT}/extensions
	newexe usr/X11R6/lib/modules/extensions/${TLS}libglx.so.${PV} libglx.so

	# The GLX libraries
	exeinto ${NV_ROOT}/lib
	doexe usr/lib/${TLS}libGL.so.${PV} \
	      usr/lib/${TLS}libGLcore.so.${PV}
	dosym libGL.so.${PV} ${NV_ROOT}/lib/libGL.so
	dosym libGL.so.${PV} ${NV_ROOT}/lib/libGL.so.1
	dosym libGLcore.so.${PV} ${NV_ROOT}/lib/libGLcore.so
	dosym libGLcore.so.${PV} ${NV_ROOT}/lib/libGLcore.so.1

	insinto /usr/X11R6/lib
	doins usr/X11R6/lib/libXvMCNVIDIA.a
	exeinto /usr/X11R6/lib
	doexe usr/X11R6/lib/libXvMCNVIDIA.so.${PV}

	# Closing bug #37517 by letting virtual/x11 provide system wide glext.h
	rm -f usr/include/GL/glext.h

	# Includes
	insinto ${NV_ROOT}/include
	doins usr/include/GL/*.h

	# Docs
	dodoc usr/share/doc/*

	# Not sure whether installing the .la file is neccessary;
	# this is adopted from the `nvidia' ebuild
	local ver1="`echo ${PV} |cut -d '.' -f 1`"
	local ver2="`echo ${PV} |cut -d '.' -f 2`"
	local ver3="`echo ${PV} |cut -d '.' -f 3`"
	sed -e "s:\${PV}:${PV}:"     \
		-e "s:\${ver1}:${ver1}:" \
		-e "s:\${ver2}:${ver2}:" \
		-e "s:\${ver3}:${ver3}:" \
		${FILESDIR}/libGL.la.2 > ${D}/${NV_ROOT}/lib/libGL.la
}

pkg_preinst() {
	#clean the dinamic libGL stuff's home to ensure
	#we dont have stale libs floating around
	if [ -d ${ROOT}/usr/lib/opengl/nvidia ]
	then
		rm -rf ${ROOT}/usr/lib/opengl/nvidia/*
	fi
	#make sure we nuke the old nvidia-glx's env.d file
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

	einfo
	einfo "To use the Nvidia GLX, run \"opengl-update nvidia\""
	einfo
}
