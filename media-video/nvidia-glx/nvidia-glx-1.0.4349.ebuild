# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-glx/nvidia-glx-1.0.4349.ebuild,v 1.2 2003/04/21 15:50:22 pfeifer Exp $

inherit eutils

# Make sure Portage does _NOT_ strip symbols.  Need both lines for
# Portage 1.8.9+
DEBUGBUILD="yes"
RESTRICT="nostrip"

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_GLX-${NV_V}"
S="${WORKDIR}/NVIDIA_GLX-${NV_V}"
DESCRIPTION="XFree86 GLX libraries for the NVIDIA's X driver"
SRC_URI="http://download.nvidia.com/XFree86/Linux-x86/${NV_V}/${NV_PACKAGE}.tar.gz"
HOMEPAGE="http://www.nvidia.com/"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -alpha -hppa -mips -arm"

# We need xfree-4.2.0-r9 to support the dynamic libGL* stuff
DEPEND="virtual/glibc
	>=x11-base/xfree-4.2.0-r9
	>=x11-base/opengl-update-1.3
	~media-video/nvidia-kernel-${PV}"

PROVIDE="virtual/opengl"

src_unpack() {
	unpack ${A}

	# correct defines to make gtkglext build work
	cd ${S}; epatch ${FILESDIR}/${PN}-1.0.4191-defines.patch

	# Check if we should install TLS versions of the libraries
	${S}/usr/bin/tls_test 2> /dev/null
	# Only trust this if we are merging to /
	if [ "$?" = "0" -a "${ROOT}" = "/" ]
	then
		touch ${WORKDIR}/.tls
	fi
}

src_install() {
	local NV_ROOT="/usr/lib/opengl/nvidia"
	local TLS=

	if [ -f "${WORKDIR}/.tls" ]
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
		${FILESDIR}/libGL.la.1 > ${D}/${NV_ROOT}/lib/libGL.la
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

